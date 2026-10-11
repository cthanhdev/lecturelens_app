# 📱 LectureLens — Flutter Mobile App (Frontend)

> **Phong cách:** "Japanese Stationery & Kawaii Study Desk" (Bàn học sổ tay pastel Nhật Bản)  
> **Linh vật:** Cú Mèo Học Tập ("Cú Mèo")  
> **Nền tảng:** Flutter & Dart (iOS, Android, Web)  
> **Phạm vi:** Giao diện hoàn chỉnh (UI/UX) với Mock Data (không phụ thuộc Backend)

---

## 🏛️ Cấu Trúc Dự Án (Feature-First Architecture)

```
lecturelens_app/
├── assets/
│   ├── svg/
│   │   ├── logo/                 # logo_full.svg, logo_icon.svg, logo_splash.svg
│   │   ├── icons/nav/            # ic_library, ic_search, ic_cu_meo_ai, ic_settings
│   │   ├── icons/actions/        # ic_upload_cloud, ic_bell, ic_bookmark, ic_play, ic_send...
│   │   ├── icons/status/         # ic_check_circle, ic_processing, ic_error, ic_star...
│   │   └── illustrations/        # empty_library, upload_zone, cu_meo_happy, cu_meo_listening
│   └── images/mascot/
├── lib/
│   ├── main.dart                 # Điểm khởi chạy app (ProviderScope, GoRouter, ThemeMode)
│   ├── core/
│   │   ├── theme/                # // !IMPORTANT: Bảng màu, Typography, BoxShadow, Spacing
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   ├── app_spacing.dart
│   │   │   ├── app_shadows.dart
│   │   │   ├── app_border_radius.dart
│   │   │   └── app_theme.dart
│   │   ├── router/               # // CHỈ DẪN: Quản lý GoRouter cho 21 màn hình
│   │   │   └── app_router.dart
│   │   ├── constants/            # AssetPaths, AppConstants
│   │   └── utils/                # DateFormatter, DurationFormatter
│   ├── shared/
│   │   ├── models/               # LectureUiModel, NotificationUiModel, SearchResultUiModel
│   │   └── widgets/              # Buttons, Cards, Chips, Inputs, Audio Player, Shimmer, Mascot...
│   └── features/
│       ├── splash/               # Màn hình Splash (4 trạng thái: Tải, Chậm, Lỗi, AI khởi động)
│       ├── onboarding/           # Giới thiệu 3 slides thân thiện
│       ├── auth/                 # Đăng nhập & Đăng ký sinh viên
│       ├── library/              # Thư viện bài giảng (Trang chủ chính)
│       ├── upload/               # Tải lên tệp âm thanh ghi âm
│       ├── processing/           # Tiến trình phân tích bài giảng AI (68%)
│       ├── lecture_detail/       # Chi tiết bài giảng (Bản ghi, Hỏi đáp AI, Mục lục)
│       ├── search/               # Tìm kiếm toàn cục xuyên suốt bài giảng
│       ├── notifications/        # Thông báo hoàn tất xử lý & nhắc ôn tập
│       └── settings/             # Hồ sơ sinh viên & chuyển đổi Sáng/Tối
└── pubspec.yaml
```

---

## 🌟 Điểm Nhấn Thiết Kế Độc Quyền

1. **Vector SVG Sắc Nét 100%:** Toàn bộ Logo, Icons điều hướng và Linh vật Cú Mèo đều được vẽ dưới định dạng SVG vector chuẩn DPI cao.
2. **Dotted Notebook Canvas (`DotBackground`):** Nền giấy màu kem `#FFFAF5` với lưới chấm bi 16px vẽ bằng `CustomPainter`.
3. **Thẻ Washi Tape & Sticky Note:** Băng dính Washi tape dán góc thẻ, giấy nhớ màu vàng bơ `#FFF1C9` xoay nhẹ `±1°` tạo chiều sâu xúc giác.
4. **Viên Nhộng Phát Âm Thanh (`AudioPlayerCapsule`):** Kính mờ `BackdropFilter` làm mờ 16dp, thanh tua chính xác và sóng âm `AudioWaveform`.
5. **Hỏi Đáp AI Cú Mèo (`AiQaTab`):** `ListView(reverse: true)` chèn tin nhắn mới tại index 0, kèm nhãn trích dẫn thời gian phát âm thanh.

---

## 🚀 Hướng Dẫn Chạy Dự Án

### 1. Cài đặt Dependencies
```bash
flutter pub get
```

### 2. Chạy trên Thiết Bị / Giả Lập / Trình Duyệt Web
```bash
# Chạy trên thiết bị di động (Android / iOS):
flutter run

# Chạy trên trình duyệt Web (Chrome):
flutter run -d chrome
```

---

## 📌 Các Điểm Đánh Dấu Cần Chú Ý Trong Code

- **`// !IMPORTANT`**: Đánh dấu các tệp/cấu hình cốt lõi nhất (`app_colors.dart`, `app_theme.dart`, `app_router.dart`, `ll_bottom_nav_bar.dart`, `lecture_ui_model.dart`, `ai_qa_tab.dart`).
- **`// CHỈ DẪN`**: Lời giải thích logic chi tiết và hướng dẫn nơi bạn có thể can thiệp tùy biến giao diện hoặc chuẩn bị tích hợp REST API sau này.
