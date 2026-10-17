# Hướng Dẫn Triển Khai Chạy Ứng Dụng LectureLens Trên iOS

Tài liệu này hướng dẫn cách đóng gói, ký số và cài đặt ứng dụng Flutter **LectureLens** lên thiết bị iPhone vật lý từ môi trường máy tính Windows 11 bằng bộ công cụ mã nguồn mở [xtool-org/xtool](https://github.com/xtool-org/xtool.git).

---

## 1. Tổng Quan Kiến Trúc

- **Bundle Identifier:** `com.lecturelens.app`
- **Display Name:** `LectureLens`
- **Môi trường build:** GitHub Actions (macOS Runner) sinh file `LectureLens-unsigned.ipa` hoàn toàn tự động.
- **Môi trường deploy:** WSL2 (Ubuntu) + `usbipd-win` + `zsign` + `xtool`.

---

## 2. Các Bước Thực Hiện

### Bước 1: Build Unsigned IPA qua GitHub Actions
1. Đẩy commit code lên nhánh `main` của repository GitHub:
   ```bash
   git add .
   git commit -m "feat: configure iOS Runner, bundle id and CI build"
   git push origin main
   ```
2. Vào tab **Actions** trên GitHub repository, chọn workflow **Build iOS IPA** -> **Run workflow**.
3. Sau khi workflow hoàn tất (khoảng 3-5 phút), tải artifact `LectureLens-ipa` về máy. Bên trong là file `LectureLens-unsigned.ipa`.

---

### Bước 2: Cài Đặt Môi Trường Trên Windows 11 (Chỉ làm lần đầu)
1. Mở PowerShell với quyền **Administrator** và cài đặt WSL2 cùng `usbipd-win`:
   ```powershell
   wsl --install -d Ubuntu
   winget install dorssel.usbipd-win
   ```
2. Khởi động lại máy nếu Windows yêu cầu.

---

### Bước 3: Cài Đặt `xtool` & `zsign` trong WSL2 (Chỉ làm lần đầu)
1. Mở terminal WSL2 Ubuntu:
   ```bash
   wsl
   ```
2. Di chuyển tới thư mục công cụ và chạy script cài đặt:
   ```bash
   cd /mnt/d/02-Projects/LectureLens/lecturelens_app/tools/ios_deploy
   chmod +x *.sh
   ./setup_wsl_xtool.sh
   ```
Script sẽ tự động:
- Cài đặt các gói phụ thuộc hệ thống (`usbmuxd`, `libimobiledevice`, `libssl-dev`, `make`, `g++`, `libfuse2`).
- Biên dịch công cụ ký số `zsign` từ mã nguồn chính thức.
- Tải bản mới nhất của `xtool` AppImage và trích xuất để chạy ổn định trong WSL2 mà không phụ thuộc kernel FUSE.

---

### Bước 4: Kết Nối iPhone Vào Máy Tính
1. Dùng cáp Lightning / Type-C cắm iPhone vào máy tính Windows.
2. Trên iPhone:
   - Nhấn **Tin cậy máy tính này (Trust This Computer)** và nhập mật mã mở khóa màn hình.
   - Bật **Chế độ nhà phát triển (Developer Mode)**: Vào *Cài đặt (Settings) -> Quyền riêng tư & Bảo mật (Privacy & Security) -> Chế độ nhà phát triển (Developer Mode)* -> Bật và khởi động lại iPhone.
3. Mở PowerShell (**Run as Administrator**) trên Windows và chạy script chuyển kết nối USB sang WSL2:
   ```powershell
   cd d:\02-Projects\LectureLens\lecturelens_app\tools\ios_deploy
   .\attach_iphone.ps1
   ```
   Script sẽ tự động liệt kê danh sách USB, thực hiện chia sẻ thiết bị (`usbipd bind`) và gắn vào WSL2 (`usbipd attach`).

---

### Bước 5: Ký Số Và Cài Đặt Qua `xtool`
Chuẩn bị chứng chỉ Apple Developer của bạn (file `.p12` và profile `.mobileprovision`). Bạn có thể sử dụng chứng chỉ Apple Developer cá nhân miễn phí (tạo từ Xcode) hoặc tài khoản Apple Developer Program.

*(Lưu ý: Tất cả file `.p12`, `.mobileprovision` và `.ipa` đã được khai báo loại trừ trong `.gitignore` để tránh rò rỉ khóa bí mật).*

Trong terminal WSL2:
```bash
cd /mnt/d/02-Projects/LectureLens/lecturelens_app/tools/ios_deploy

# Trường hợp chứng chỉ .p12 CÓ mật khẩu:
./sign_and_install.sh \
  /path/to/LectureLens-unsigned.ipa \
  /path/to/dev_cert.p12 \
  "password_cua_cert" \
  /path/to/embedded.mobileprovision

# Hoặc nếu chứng chỉ .p12 KHÔNG CÓ mật khẩu:
./sign_and_install.sh \
  /path/to/LectureLens-unsigned.ipa \
  /path/to/dev_cert.p12 \
  /path/to/embedded.mobileprovision
```

Script sẽ:
1. Dùng `zsign` ký số lại file `.ipa` theo đúng Provisioning Profile và UDID của iPhone.
2. Khởi động lại dịch vụ `usbmuxd` và kiểm tra thiết bị qua `xtool devices`.
3. Cài đặt file signed `.ipa` vào iPhone bằng `xtool install`.
4. Kích hoạt mở ứng dụng `LectureLens` bằng `xtool launch com.lecturelens.app`.

---

## 3. Lưu Ý & Khắc Phục Lỗi

- **Lỗi `MIErrorFailedToVerifyCodeSignature`:** File `.ipa` chưa được ký số hoặc provisioning profile không chứa UDID của thiết bị iPhone hiện tại. Đảm bảo dùng `zsign` với đúng profile có đăng ký UDID của máy.
- **`xtool devices` không thấy iPhone:** 
  1. Kiểm tra trên Windows bằng lệnh `usbipd list` xem iPhone đã ở trạng thái `Attached` chưa.
  2. Đảm bảo màn hình iPhone đã mở khóa và đã chọn "Trust this computer".
  3. Trong WSL2 chạy `sudo service usbmuxd restart`.
- **Duy trì kết nối khi rút cáp/cắm lại:** Sử dụng tham số `--auto-attach` trong PowerShell:
  ```powershell
  usbipd attach --wsl --busid <BUSID> --auto-attach
  ```
- **Phương án thay thế (xcross):** Có thể tham khảo công cụ [xcross](https://github.com/xtool-org/xcross) chạy trực tiếp trên Windows PowerShell để hỗ trợ dev loop và hot-reload `flutter run` qua CoreDevice tunnel.
