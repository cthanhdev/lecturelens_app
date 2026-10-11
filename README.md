# 📱 LectureLens — AI Lecture Companion Mobile App

<p align="center">
  <img src="assets/svg/logo/logo_full.svg" alt="LectureLens Logo" width="280"/>
</p>

<p align="center">
  <strong>Biến bài giảng thành kho tri thức — Người bạn đồng hành học tập thông minh cho sinh viên</strong>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.2.0+-02569B?logo=flutter&logoColor=white&style=for-the-badge" alt="Flutter Version" /></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.2.0+-0175C2?logo=dart&logoColor=white&style=for-the-badge" alt="Dart Version" /></a>
  <a href="https://riverpod.dev"><img src="https://img.shields.io/badge/State-Riverpod_2.x-00B4D8?style=for-the-badge" alt="Riverpod" /></a>
  <a href="https://pub.dev/packages/go_router"><img src="https://img.shields.io/badge/Router-GoRouter_13.x-8338EC?style=for-the-badge" alt="GoRouter" /></a>
  <a href="#"><img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-3A86FF?style=for-the-badge" alt="Platforms" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-2EC4B6?style=for-the-badge" alt="License" /></a>
</p>

---

## 📖 Mục Lục

- [Giới Thiệu Dự Án](#-giới-thiệu-dự-án)
- [Điểm Nhấn Thiết Kế UI/UX](#-điểm-nhấn-thiết-kế-uiux)
- [Tính Năng Nổi Bật](#-tính-năng-nổi-bật)
- [Kiến Trúc & Công Nghệ](#-kiến-trúc--công-nghệ)
- [Cấu Trúc Thư Mục Dự Án](#-cấu-trúc-thư-mục-dự-án)
- [Bảng Định Tuyến (Routing Catalog)](#-bảng-định-tuyến-routing-catalog)
- [Hệ Thống Thiết Kế (Design System)](#-hệ-thống-thiết-kế-design-system)
- [Yêu Cầu Hệ Thống & Cài Đặt](#-yêu-cầu-hệ-thống--cài-đặt)
- [Hướng Dẫn Khởi Chạy Ứng Dụng](#-hướng-dẫn-khởi-chạy-ứng-dụng)
- [Hướng Dẫn Build Bản Phát Hành](#-hướng-dẫn-build-bản-phát-hành)
- [Quy Chuẩn Lập Trình & Quy Ước Mã](#-quy-chuẩn-lập-trình--quy-ước-mã)
- [Lộ Trình Phát Triển (Roadmap)](#-lộ-trình-phát-triển-roadmap)
- [Đóng Góp & Giấy Phép](#-đóng-góp--giấy-phép)

---

## 💡 Giới Thiệu Dự Án

**LectureLens** là ứng dụng di động hỗ trợ học tập thông minh thế hệ mới dành cho sinh viên và người học hiện đại. Ứng dụng giải quyết triệt để vấn đề ghi chép quá tải trong các buổi giảng kéo dài hàng giờ bằng cách:

1. **Ghi âm & Chuyển đổi thông minh:** Tự động lắng nghe và trích xuất toàn bộ bản ghi âm bài học trên giảng đường thành văn bản (Speech-to-Text).
2. **Bộ não AI Cú Mèo:** Lập chỉ mục chủ đề, phân đoạn mục lục, gắn nhãn trích dẫn thời gian phát âm thanh và trả lời các câu hỏi ôn tập theo ngữ cảnh bài học.
3. **Cảm hứng Bàn học Pastel Nhật Bản:** Kết hợp trải nghiệm công nghệ AI tiên tiến với giao diện sổ tay thủ công ấm áp, giảm bớt căng thẳng thi cử và khơi gợi niềm vui học tập mỗi ngày.

---

## 🎨 Điểm Nhấn Thiết Kế UI/UX

Ứng dụng được xây dựng theo phong cách độc quyền **"Japanese Stationery & Kawaii Study Desk"**:

- **Nền Giấy Sổ Tay Chấm Bi (`DotBackground`):** Sử dụng `CustomPainter` vẽ hệ lưới chấm tròn cách đều 16px, bán kính 1.1px trên tone màu kem ấm `#FFFAF5`, mô phỏng chính xác chất liệu giấy chấm sổ tay bullet journal cao cấp.
- **Thẻ Ghi Chú Washi Tape & Giấy Nhớ:** Các thẻ bài học được đính kèm họa tiết băng dính washi tape pastel nhiều màu và các khối trích dẫn sticky note vàng bơ xoay góc tự nhiên `±1°`.
- **Thanh Điều Hướng Viên Nhộng Nổi (`LlBottomNavBar`):** Thiết kế dạng pill cong tròn thanh thoát, sử dụng `BackdropFilter` hiệu ứng kính mờ (Frosted Glass Blur 16dp) kết hợp đổ bóng mềm mịn.
- **Hoạt Cảnh Cuộn Thông Minh (Scroll-Aware Animation):** Tự động phát hiện hướng cuộn (`UserScrollNotification`) để ẩn êm ái cả thanh điều hướng và nút tải lên FAB khi lướt xuống, tối đa hóa không gian đọc và tái hiện ngay khi cuộn ngược lên.
- **Vector SVG Chuẩn 100%:** Toàn bộ biểu tượng, logo thương hiệu và các trạng thái cảm xúc của linh vật Cú Mèo đều được render vector chuẩn nét trên mọi độ phân giải màn hình.

---

## 🚀 Tính Năng Nổi Bật

### 1. 📚 Thư Viện Bài Giảng Đa Năng (Home Library)
- Danh sách bài giảng trực quan phân định rõ trạng thái: **Đã sẵn sàng** (`Ready`) và **Đang xử lý** (`Processing`).
- Bộ lọc nhanh theo tab ngang: *Tất cả*, *Sẵn sàng*, *Đang xử lý*, *Công nghệ*.
- Thanh tìm kiếm thời gian thực theo tiêu đề, môn học, trích dẫn bài học hoặc thẻ môn.
- Nút tác vụ nổi FAB *"Tải bản ghi lên"* được tính toán độ cao động thông minh, luôn bay an toàn phía trên thanh điều hướng ở mọi tỉ lệ màn hình.

### 2. 🤖 Trợ Lý Trí Tuệ Nhân Tạo "Cú Mèo AI" (Lecture AI Q&A)
- Hỏi đáp chuyên sâu trực tiếp trên ngữ cảnh bài giảng vừa học.
- Đính kèm thẻ trích dẫn mốc phát âm thanh chuẩn xác đến từng giây (ví dụ: `[Phát từ 12:35]`).
- Gợi ý câu hỏi thông minh theo chủ đề giúp người học đào sâu kiến thức.

### 3. 🎙️ Tải Lên & Xử Lý Âm Thanh Trực Quan
- Hỗ trợ tải tệp ghi âm bài giảng đa định dạng (`.mp3`, `.m4a`, `.wav`, `.aac`).
- Màn hình tiến trình phân tích trực quan: thanh đo tiến độ gradient, đếm ngược thời gian ước tính và linh vật Cú Mèo lắng nghe bài học.

### 4. 🎧 Chi Tiết Bài Giảng & Trình Phát Nhộng Âm Thanh
- **Viên nhộng phát âm thanh (`AudioPlayerCapsule`):** Thanh tua thời gian chính xác, sóng âm động học (`AudioWaveform`), nút chuyển tốc độ phát (`1.0x`, `1.25x`, `1.5x`, `2.0x`).
- **Mục lục thông minh (Table of Contents):** Phân đoạn bài giảng theo các chủ đề cốt lõi.
- **Bản ghi lời nói (Transcript):** Từng đoạn hội thoại kèm timestamp, click vào để nhảy bài phát ngay lập tức.

### 5. 🔍 Tìm Kiếm Toàn Cục & Lọc Nâng Cao
- Tìm kiếm từ khóa xuyên suốt tất cả bài giảng, các câu hỏi AI và ghi chú đã lưu.
- Lưu lại lịch sử tìm kiếm gần đây và danh sách từ khóa xu hướng.

### 6. ⚙️ Cá Nhân Hóa & Chuyển Đổi Giao Diện Sáng / Tối
- Hồ sơ sinh viên, quản lý trường đại học và thông tin lưu trữ.
- Hỗ trợ Dark Mode (`ThemeMode.dark`) với hệ màu đêm pastel huyền bí bảo vệ thị giác khi học bài ban đêm.

---

## 🛠️ Kiến Trúc & Công Nghệ

Dự án áp dụng mô hình **Feature-First Architecture** kết hợp nguyên lý phân tách trách nhiệm (Separation of Concerns):

```
                        ┌───────────────────────────────┐
                        │      Application Entry        │
                        │        (lib/main.dart)        │
                        └──────────────┬────────────────┘
                                       │
                ┌──────────────────────┴──────────────────────┐
                ▼                                             ▼
  ┌───────────────────────────┐                 ┌───────────────────────────┐
  │   Core & State Providers  │                 │   GoRouter App Router     │
  │   - AppTheme / AppColors  │                 │   - Deep Linking          │
  │   - Riverpod Providers    │                 │   - Smooth Transitions    │
  │   - Constants & Utils     │                 │   - 404 Route Protection  │
  └─────────────┬─────────────┘                 └─────────────┬─────────────┘
                │                                             │
                └──────────────────────┬──────────────────────┘
                                       ▼
                     ┌───────────────────────────────────┐
                     │         Feature Modules           │
                     │  (Auth, Library, Lecture Detail,  │
                     │   Processing, Search, Settings)   │
                     └─────────────────┬─────────────────┘
                                       ▼
                     ┌───────────────────────────────────┐
                     │    Shared Components & Models     │
                     │  (Cards, Audio Capsule, Skeletons,│
                     │   DotBackground, Custom Buttons)  │
                     └───────────────────────────────────┘
```

### Công Nghệ Chủ Chốt:
| Thư viện / Công nghệ | Phiên bản | Mục đích sử dụng |
| :--- | :--- | :--- |
| **Flutter SDK** | `>=3.2.0` | Framework đa nền tảng cốt lõi |
| **Dart SDK** | `3.x` | Ngôn ngữ lập trình |
| **flutter_riverpod** | `^2.5.1` | Quản lý trạng thái toàn cục (Theme, User Profile, Notifications) |
| **go_router** | `^13.2.0` | Điều hướng, deep linking và hiệu ứng chuyển trang tùy chỉnh |
| **flutter_svg** | `^2.0.10` | Render vector đồ họa chuẩn độ nét cao |
| **shimmer** | `^3.0.0` | Hiệu ứng tải trang bộ xương (Skeleton Shimmer) |
| **flutter_animate** | `^4.5.0` | Vi hoạt ảnh giao diện tương tác |
| **google_fonts** | `^6.2.1` | Typography: Quicksand (Tiêu đề) & Nunito Sans (Nội dung) |
| **intl** | `^0.19.0` | Định dạng ngày giờ và thời lượng học |

---

## 📁 Cấu Trúc Thư Mục Dự Án

```
lecturelens_app/
├── assets/
│   ├── svg/
│   │   ├── logo/                 # logo_full.svg, logo_icon.svg, logo_splash.svg
│   │   ├── icons/nav/            # ic_library.svg, ic_search.svg, ic_cu_meo_ai.svg, ic_settings.svg
│   │   ├── icons/actions/        # ic_upload_cloud.svg, ic_bell.svg, ic_bookmark.svg, ic_play.svg...
│   │   ├── icons/status/         # ic_check_circle.svg, ic_processing.svg, ic_error.svg, ic_clock.svg...
│   │   └── illustrations/        # empty_library.svg, upload_zone.svg, cu_meo_listening.svg...
├── lib/
│   ├── main.dart                 # Điểm khởi chạy app (ProviderScope, MaterialApp.router)
│   ├── core/
│   │   ├── constants/            # AssetPaths, AppConstants
│   │   ├── providers/            # Riverpod State Providers (UserProfile, ThemeMode, Notifications)
│   │   ├── router/               # AppRouter (Cấu hình GoRouter, Page Transitions, 404 Screen)
│   │   ├── theme/                # Tokens thiết kế: Colors, Typography, Spacing, Shadows, Theme
│   │   └── utils/                # DateFormatter, DurationFormatter
│   ├── shared/
│   │   ├── models/               # LectureUiModel, NotificationUiModel, SearchResultUiModel
│   │   └── widgets/              # Reusable UI widgets:
│   │       ├── audio/            # AudioPlayerCapsule, AudioProgressBar, AudioWaveform
│   │       ├── buttons/          # LlPrimaryButton, LlIconCircleButton
│   │       ├── cards/            # LectureCard, ProcessingCard, StickyNoteCard
│   │       ├── chips/            # StatusChip, SubjectChip, TimestampChip
│   │       ├── inputs/           # LlSearchBar, LlTextField
│   │       ├── mascot/           # CuMeoEmptyState
│   │       ├── navigation/       # LlBottomNavBar (Floating frosted pill)
│   │       ├── skeleton/         # LectureCardSkeleton, LectureDetailSkeleton
│   │       ├── washi_tape/       # WashiTapeAccent
│   │       ├── dot_background.dart # Canvas nền giấy chấm bi sổ tay
│   │       ├── ll_app_bar.dart   # Thanh AppBar chuẩn mờ kính
│   │       └── notification_badge.dart
│   └── features/
│       ├── splash/               # Màn hình Splash khởi động, AI loader
│       ├── onboarding/           # 3 Slides giới thiệu app tương tác
│       ├── auth/                 # Đăng nhập & Đăng ký tài khoản sinh viên
│       ├── library/              # Thư viện bài giảng (Màn hình chính)
│       ├── upload/               # Tải lên file ghi âm bài học
│       ├── processing/           # Tiến trình phân tích bài giảng AI thời gian thực
│       ├── lecture_detail/       # Chi tiết bài học (Transcript, AI Q&A, Mục lục)
│       ├── search/               # Tìm kiếm toàn cục
│       ├── notifications/        # Trung tâm thông báo ôn tập
│       └── settings/             # Cài đặt cá nhân & Đổi chủ đề Sáng/Tối
├── pubspec.yaml                  # Khai báo dependencies & asset paths
└── README.md                     # Tài liệu hướng dẫn dự án chuẩn
```

---

## 🗺️ Bảng Định Tuyến (Routing Catalog)

| Tuyến đường (Route Path) | Màn hình (Screen) | Mô tả chức năng |
| :--- | :--- | :--- |
| `/` (`/splash`) | `SplashScreen` | Màn hình chào với linh vật Cú Mèo và hiệu ứng Halo |
| `/onboarding` | `OnboardingScreen` | 3 bước hướng dẫn sử dụng thân thiện cho người mới |
| `/login` | `LoginScreen` | Đăng nhập tài khoản sinh viên |
| `/register` | `RegisterScreen` | Đăng ký tài khoản mới kèm chọn trường đại học |
| `/library` | `LibraryScreen` | Trang chủ thư viện bài giảng, tìm kiếm và phân loại |
| `/upload` | `UploadScreen` | Tải lên file ghi âm bài giảng |
| `/processing` | `ProcessingScreen` | Theo dõi tiến trình AI bóc tách bài học (68%) |
| `/lecture/:id` | `LectureDetailScreen` | Xem chi tiết bài giảng, nghe audio, xem bản ghi |
| `/lecture/:id/ai` | `LectureDetailScreen` (Tab AI) | Hỏi đáp trực tiếp với trợ lý Cú Mèo AI |
| `/search` | `SearchScreen` | Tìm kiếm toàn cục bài giảng và từ khóa |
| `/notifications` | `NotificationsScreen` | Thông báo hoàn tất phân tích & nhắc nhở ôn bài |
| `/settings` | `SettingsScreen` | Cài đặt tài khoản, thông tin ứng dụng & Dark Mode |

---

## 🎨 Hệ Thống Thiết Kế (Design System)

### Bảng Màu Chuẩn (Color Palette Tokens)
| Tên Token | Mã Hex | Ý nghĩa sử dụng |
| :--- | :--- | :--- |
| **`primary`** | `#5445B6` | Màu tím Indigo chủ đạo của thương hiệu |
| **`primaryContainer`** | `#6D5FD0` | Tím pastel nhấn nút bấm chính và thẻ nổi bật |
| **`canvasCream`** | `#FFFAF5` | Màu nền giấy sổ tay kem ấm đặc trưng |
| **`dotColor`** | `#EADBCE` | Màu chấm bi lưới giấy sổ tay |
| **`stickyYellow`** | `#FFF1C9` | Giấy ghi nhớ bơ vàng đính kèm bài học |
| **`mintGreen`** | `#D8F3DC` | Màu Washi tape xanh bạc hà, biểu thị trạng thái sẵn sàng |
| **`sakuraPink`** | `#FFE5EC` | Màu Washi tape hồng hoa anh đào |
| **`warning`** | `#E5A800` | Màu vàng cảnh báo bài giảng đang phân tích |

### Typography
- **Tiêu đề (Headlines & Titles):** Font chữ `Quicksand` bo tròn mềm mại, tạo cảm giác thân thiện, tích cực.
- **Nội dung & Nhãn (Body & Labels):** Font chữ `Nunito Sans` rõ ràng, thanh thoát, tối ưu hóa tối đa cho việc đọc văn bản dài trên màn hình di động.

---

## 💻 Yêu Cầu Hệ Thống & Cài Đặt

### Yêu Cầu Tiên Quyết:
- **Flutter SDK:** Phiên bản `3.2.0` trở lên ([Hướng dẫn cài đặt Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK:** Phiên bản `3.2.0` trở lên
- **Công cụ hỗ trợ:** Android Studio (cho máy ảo Android), Xcode (cho iOS trên macOS), hoặc Google Chrome (cho nền tảng Web).

### Cài Đặt Dự Án:

1. **Clone repository về máy:**
   ```bash
   git clone https://github.com/your-username/LectureLens.git
   cd LectureLens/lecturelens_app
   ```

2. **Cài đặt các gói thư viện phụ thuộc:**
   ```bash
   flutter pub get
   ```

3. **Kiểm tra môi trường phát triển:**
   ```bash
   flutter doctor
   ```

---

## 🏃 Hướng Dẫn Khởi Chạy Ứng Dụng

### 1. Chạy trên Thiết Bị Thật hoặc Máy Ảo Di Động:
```bash
# Liệt kê danh sách thiết bị đang kết nối
flutter devices

# Khởi chạy trên thiết bị mặc định
flutter run

# Khởi chạy trên thiết bị cụ thể (ví dụ máy ảo Android)
flutter run -d emulator-5554
```

### 2. Chạy trên Trình Duyệt Web (Chrome):
```bash
flutter run -d chrome
```

### 3. Phím Tắt Khi Đang Chạy Debug:
- Nhấn `r`: **Hot Reload** (cập nhật thay đổi UI tức thì).
- Nhấn `R`: **Hot Restart** (khởi động lại toàn bộ state ứng dụng).
- Nhấn `q`: Thoát phiên chạy.

---

## 📦 Hướng Dẫn Build Bản Phát Hành

### 1. Build Android (APK / App Bundle):
```bash
# Build file APK cài đặt trực tiếp
flutter build apk --release

# Build Android App Bundle (.aab) để đẩy lên Google Play Store
flutter build appbundle --release
```

### 2. Build iOS:
*(Yêu cầu thực hiện trên hệ điều hành macOS)*
```bash
flutter build ipa --release
```

### 3. Build Web:
```bash
flutter build web --release
```

---

## 📝 Quy Chuẩn Lập Trình & Quy Ước Mã

Nhằm duy trì chất lượng mã nguồn cao và dễ dàng mở rộng sang Backend REST API, dự án áp dụng các nguyên tắc:

- **Đánh dấu ghi chú đặc biệt:**
  - `// !IMPORTANT`: Đánh dấu các tệp/cấu hình cốt lõi nhất không được phép thay đổi cấu trúc tùy tiện (`app_colors.dart`, `app_router.dart`, `ll_bottom_nav_bar.dart`).
  - `// CHỈ DẪN`: Lời giải thích luồng hoạt động chi tiết và chỉ dẫn nơi tích hợp API hoặc xử lý logic dữ liệu.
- **Không Hardcode Đường Dẫn Asset:** Mọi đường dẫn SVG, hình ảnh và icon đều phải thông qua lớp [AssetPaths](file:///d:/02-Projects/LectureLens/lecturelens_app/lib/core/constants/asset_paths.dart).
- **Tránh Overflow Linh Hoạt:** Luôn sử dụng `Expanded`, `Flexible` kết hợp `TextOverflow.ellipsis` trong các khối `Row` chứa nội dung động.

---

## 🗺️ Lộ Trình Phát Triển (Roadmap)

- [x] Hoàn thiện hệ thống Design System chuẩn sổ tay Kawaii Stationery.
- [x] Triển khai toàn diện 21 màn hình UI & điều hướng GoRouter mượt mà.
- [x] Tích hợp hoạt cảnh cuộn ẩn/hiện thanh điều hướng thông minh.
- [x] Tối ưu hóa hiển thị responsive trên cả Mobile và Web.
- [ ] Tích hợp Backend API (FastAPI / Node.js) cho tiến trình phân tích âm thanh thực tế.
- [ ] Tích hợp mô hình ngôn ngữ lớn (LLM - Gemini API) trả lời hỏi đáp thời gian thực.
- [ ] Tính năng xuất ghi chú định dạng Markdown và PDF.

---

## 🤝 Đóng Góp & Giấy Phép

Mọi đóng góp nhằm cải thiện và phát triển **LectureLens** đều được hoan nghênh nồng nhiệt!

1. Fork dự án (`Fork repository`).
2. Tạo nhánh tính năng mới (`git checkout -b feature/AmazingFeature`).
3. Commit thay đổi (`git commit -m 'feat: Add some AmazingFeature'`).
4. Push nhánh của bạn (`git push origin feature/AmazingFeature`).
5. Mở một **Pull Request** mới.

Dự án được phân phối dưới giấy phép **MIT License**. Chi tiết xem tại tệp `LICENSE`.

<p align="center">
  Được phát triển với tất cả tâm huyết dành cho cộng đồng sinh viên và người học Việt Nam 🇻🇳 🦉
</p>
