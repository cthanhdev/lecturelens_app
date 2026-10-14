# 📱 LectureLens — AI Lecture Companion Mobile App

<p align="center">
  <img src="assets/svg/logo/logo_full.svg" alt="LectureLens Logo" width="320"/>
</p>

<p align="center">
  <strong>Biến bài giảng thành kho tri thức — Người bạn đồng hành học tập thông minh cho sinh viên</strong>
</p>

<p align="center">
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-3.2.0%2B-02569B?logo=flutter&logoColor=white&style=for-the-badge" alt="Flutter Version" /></a>
  <a href="https://dart.dev"><img src="https://img.shields.io/badge/Dart-3.2.0%2B-0175C2?logo=dart&logoColor=white&style=for-the-badge" alt="Dart Version" /></a>
  <a href="https://riverpod.dev"><img src="https://img.shields.io/badge/State-Riverpod_2.5%2B-00B4D8?style=for-the-badge" alt="Riverpod" /></a>
  <a href="https://pub.dev/packages/go_router"><img src="https://img.shields.io/badge/Router-GoRouter_13.2%2B-8338EC?style=for-the-badge" alt="GoRouter" /></a>
  <a href="#"><img src="https://img.shields.io/badge/Tests-32%20Passed-10B981?style=for-the-badge" alt="Tests Status" /></a>
  <a href="#"><img src="https://img.shields.io/badge/Analyze-0%20Issues-3B82F6?style=for-the-badge" alt="Analyze Status" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-2EC4B6?style=for-the-badge" alt="License" /></a>
</p>

---

## 📖 Mục Lục

1. [Giới Thiệu Dự Án & Tầm Nhìn Sản Phẩm](#-giới-thiệu-dự-án--tầm-nhìn-sản-phẩm)
2. [Điểm Nhấn Thiết Kế UI/UX & Hệ Thống Chuyển Động](#-điểm-nhấn-thiết-kế-uiux--hệ-thống-chuyển-động)
3. [Tính Năng Cốt Lõi (Core Features Walkthrough)](#-tính-năng-cốt-lõi-core-features-walkthrough)
4. [Sơ Đồ Kiến Trúc Phần Mềm & Công Nghệ](#-sơ-đồ-kiến-trúc-phần-mềm--công-nghệ)
5. [Cấu Trúc Thư Mục Dự Án Chuẩn Mực](#-cấu-trúc-thư-mục-dự-án-chuẩn-mực)
6. [Bảng Định Tuyến & Luồng Điều Hướng (Routing Catalog)](#-bảng-định-tuyến--luồng-điều-hướng-routing-catalog)
7. [Hệ Thống Thiết Kế & Design Tokens](#-hệ-thống-thiết-kế--design-tokens)
8. [Yêu Cầu Hệ Thống & Hướng Dẫn Cài Đặt](#-yêu-cầu-hệ-thống--hướng-dẫn-cài-đặt)
9. [Hướng Dẫn Khởi Chạy Ứng Dụng](#-hướng-dẫn-khởi-chạy-ứng-dụng)
10. [Hướng Dẫn Build Bản Phát Hành (Release)](#-hướng-dẫn-build-bản-phát-hành-release)
11. [Quy Chuẩn Lập Trình & Quản Lý Trạng Thái](#-quy-chuẩn-lập-trình--quản-lý-trạng-thái)
12. [Lộ Trình Phát Triển (Roadmap) & Giấy Phép](#-lộ-trình-phát-triển-roadmap--giấy-phép)

---

## 💡 Giới Thiệu Dự Án & Tầm Nhìn Sản Phẩm

### Vấn Đề Thực Tế Của Sinh Viên
Các buổi giảng trên giảng đường đại học hiện đại thường kéo dài từ 2 đến 4 tiếng đồng hồ với mật độ kiến thức dày đặc:
- **Quá tải nhận thức (Cognitive Overload):** Vừa phải nghe giảng, vừa phải ghi chép tốc ký dẫn đến bỏ lỡ những luận điểm trọng tâm.
- **Khó khăn khi ôn tập:** Các tệp ghi âm thô hàng trăm megabyte rất khó để tra cứu lại một công thức hay một ví dụ cụ thể của giảng viên.
- **Căng thẳng học tập:** Giao diện các công cụ hỗ trợ học tập truyền thống thường khô khan, nặng nề, làm gia tăng áp lực mùa thi cử.

### Giải Pháp Đột Phá — LectureLens
**LectureLens** là ứng dụng di động & web được xây dựng với sứ mệnh biến mọi buổi học trở thành một trải nghiệm thú vị, nhẹ nhàng và hiệu quả vượt bậc:
- **Speech-to-Text Thông Minh (Whisper AI Engine):** Tự động chuyển đổi bản ghi âm bài giảng thành văn bản có cấu trúc phân đoạn rõ ràng kèm nhãn thời gian (timestamp).
- **Trợ Lý Học Tập AI "Cú Mèo":** Phân tích ngữ cảnh bài học, trích xuất mục lục chủ đề tự động, gắn thẻ ghi chú trọng tâm ôn thi và trả lời mọi câu hỏi của sinh viên với dẫn chứng mốc âm thanh chính xác.
- **Phong Cách Bàn Học Ấm Áp (Japanese Stationery & Kawaii Study Desk):** Mang hơi thở của sổ tay bullet journal, băng dính washi tape và giấy nhớ pastel vào từng khung hình số, giúp sinh viên cảm thấy thư thái và tràn đầy cảm hứng học tập mỗi ngày.

---

## 🎨 Điểm Nhấn Thiết Kế UI/UX & Hệ Thống Chuyển Động

Ứng dụng LectureLens sở hữu ngôn ngữ thiết kế độc bản kết hợp giữa công nghệ hiện đại và thẩm mỹ thủ công Nhật Bản:

### 1. Canvas Giấy Sổ Tay Chấm Bi (`DotBackground`)
- Được render tối ưu hiệu năng thông qua `CustomPainter` và `RepaintBoundary`.
- Hệ lưới chấm tròn cách đều **16.0 px**, bán kính chấm **1.1 px** phủ trên tone kem ấm `#FFFAF5`.
- Tái hiện chân thực chất giấy dot-grid của các dòng sổ tay học tập cao cấp, không gây mỏi mắt khi đọc trong thời gian dài.

### 2. Linh Vật Sống Động "Cú Mèo AI" (`CuMeoWidget`)
- Hệ thống linh vật đa biểu cảm vector SVG độc quyền chuẩn hóa theo enum `CuMeoVariant`:
  - *Nghỉ ngơi (`idle`):* Nhịp thở nhẹ nhàng, sẵn sàng đồng hành học tập.
  - *Lắng nghe (`listening`):* Nghiêng đầu chú ý theo âm thanh bài giảng.
  - *Hạnh phúc (`happy`):* Biểu cảm rạng rỡ khi bài giảng hoàn tất hoặc sinh viên học tốt.
  - *Ngủ say (`sleeping`):* Đậu trên cành ngủ thư thái khi thư viện trống hoặc lỗi 404.
  - *Xử lý (`processing`):* Chăm chú tập trung khi bộ não AI bóc tách giọng nói.
- Tích hợp nhịp thở sinh học tự nhiên (Ambient Breathing Motion `2400ms` tuần hoàn qua `Curves.easeInOutSine`).
- Tự động phản hồi chuyển động nảy xúc giác khi chạm (`HapticFeedback.lightImpact`).

### 3. Họa Tiết Băng Dính Washi Tape & Giấy Ghi Nhớ Sticky Note
- Các thẻ bài học và đoạn ghi chép quan trọng được đính kèm chi tiết băng dính washi tape pastel (`sakuraPink`, `mintGreen`, `butterYellow`, `lavender`).
- Khối trích dẫn sticky note vàng bơ với độ xoay tự nhiên `±1°`, tạo cảm giác chân thực như một trang sổ tay được sinh viên tự tay đánh dấu.

### 4. Thanh Điều Hướng Viên Nhộng Nổi (`LlBottomNavBar`)
- Thiết kế hình viên nhộng (Floating Pill) bo góc `999.0` với hiệu ứng kính mờ `BackdropFilter` (Blur `16.0 dp`).
- Tự động thích ứng màu nền khi chuyển đổi giữa chế độ Sáng (Light Mode) và Tối (Dark Mode).
- Chỉ báo chuyển tab dạng đốm sáng mượt mà, hỗ trợ huy hiệu đếm thông báo động (`NotificationBadge`).

### 5. Hoạt Cảnh Cuộn Thông Minh (Scroll-Aware Motion)
- Ứng dụng lắng nghe thông báo cuộn trực tiếp (`UserScrollNotification`) từ danh sách bài giảng.
- Tự động ẩn êm ái cả thanh điều hướng đáy và nút tải lên FAB khi người dùng lướt xuống để đọc tài liệu.
- Lập tức tái hiện nhẹ nhàng ngay khi người dùng cuộn ngược lên hoặc chạm nhẹ vào màn hình.

### 6. Phản Hồi Xúc Giác Đàn Hồi (`LlPressable` & Tactile Press)
- Toàn bộ nút bấm, thẻ bài giảng và chip tương tác đều được bao bọc bởi widget `LlPressable`.
- Hiệu ứng thu nhỏ tinh tế (`scaleFactor = 0.965`) khi chạm ngón tay xuống và đàn hồi trở lại tự nhiên khi nhấc ngón tay lên, tạo cảm giác xúc giác cơ học chân thực.

### 7. Chuyển Đổi Thực Thể Liền Mạch (Hero Transition & Shared-Surface Motion)
- **Shared-Element Hero:** Chuyển cảnh mượt mà giữa Thẻ bài giảng (`LectureCard`) sang Màn hình chi tiết (`LectureDetailScreen`), biểu tượng bìa bài học và linh vật Cú Mèo bay lượn định vị chính xác giữa 2 khung nhìn không bị ngắt quãng.
- **Auth Shared-Surface:** Chuyển cảnh giữa Đăng nhập (`LoginScreen`) và Đăng ký (`RegisterScreen`) với thuật toán điều tiết độ mờ xen kẽ (Interval curves) và tỉ lệ kích thước (Scale 0.965 -> 1.0), ngăn chặn triệt để hiện tượng chồng bóng chữ (double-exposure).

---

## 🚀 Tính Năng Cốt Lõi (Core Features Walkthrough)

```
      [ Tải Lên / Ghi Âm ] ────────► [ Phân Tích AI 68% ] ────────► [ Kho Bài Giảng Sẵn Sàng ]
             │                                                                │
             ▼                                                                ▼
   Drag-and-Drop Audio                                          ┌────────────────────────────┐
   Định dạng: MP3, M4A, WAV                                     │    Chi Tiết Bài Giảng      │
                                                                ├────────────────────────────┤
                                                                │ 1. Mục Lục Chủ Đề (TOC)    │
                                                                │ 2. Trợ Lý Cú Mèo AI        │
                                                                │ 3. Bản Ghi Chép Transcript │
                                                                │ 4. Viên Nhộng Âm Thanh     │
                                                                └────────────────────────────┘
```

### 1. 📚 Thư Viện Bài Giảng Đa Năng (Home Library)
- **Hiển thị trực quan theo trạng thái:** Phân định rõ ràng giữa bài giảng *Đã sẵn sàng* (`Ready`) và bài giảng *Đang phân tích* (`Processing`).
- **Bộ lọc tab ngang linh hoạt:** Lọc nhanh theo các tiêu chí *Tất cả*, *Sẵn sàng*, *Đang xử lý*, và *Môn học*.
- **Chế độ kiểm thử đa góc nhìn:** Tích hợp bộ chuyển đổi chế độ xem nhanh: Bình thường (`normal`), Trống bài giảng (`empty`), và Tải khung xương (`skeleton`).
- **Nút tải lên thông minh (FAB):** Tự động căn chỉnh cao độ động an toàn bên trên thanh điều hướng nổi ở mọi tỉ lệ màn hình.

### 2. 🤖 Trợ Lý Trí Tuệ Nhân Tạo Cú Mèo AI (Contextual AI Q&A)
- **Hỏi đáp bám sát bài giảng:** Đặt câu hỏi thắc mắc và nhận câu trả lời phân tích chuyên sâu dựa trên chính ngữ cảnh bài giảng vừa thu âm.
- **Trích dẫn mốc thời gian phát:** Mọi câu trả lời của AI đều gắn kèm thẻ trích dẫn thời gian phát (ví dụ: `[Phát từ 12:35]`).
- **Tương tác một chạm (One-tap Jump):** Nhấn trực tiếp vào thẻ trích dẫn để trình phát âm thanh lập tức tua tới đúng câu nói của thầy cô.
- **Gợi ý câu hỏi ôn thi:** Tự động đề xuất các câu hỏi ôn tập trọng tâm giúp sinh viên đào sâu kiến thức.

### 3. 🎙️ Tải Lên & Theo Dõi Tiến Trình Phân Tích (Upload & Processing)
- **Khu vực thả tệp trực quan (`UploadDropZone`):** Hỗ trợ kéo thả hoặc chọn tệp âm thanh ghi âm bài giảng (`.mp3`, `.m4a`, `.wav`, `.aac`).
- **Biểu mẫu thông tin bổ sung:** Nhập tên bài giảng, phân loại môn học và trường đại học.
- **Dòng thời gian phân tích thời gian thực (`ProcessingTimeline`):**
  1. *Tải lên máy chủ bảo mật (100%)*
  2. *Chuyển đổi âm thanh thành văn bản Whisper AI (100%)*
  3. *Tách chủ đề & lập mục lục thông minh (68%)*
  4. *Chuẩn bị trợ lý Cú Mèo & thẻ ghi nhớ (Chờ)*
- **Ước tính thời gian hoàn thành:** Đồng hồ đếm ngược thông minh kèm linh vật Cú Mèo chăm chú lắng nghe.

### 4. 🎧 Chi Tiết Bài Giảng & Trình Phát Nhộng Âm Thanh (`AudioPlayerCapsule`)
- **Trình phát viên nhộng độc quyền:** Tích hợp trực tiếp trên đầu trang chi tiết, hiển thị tiêu đề, tên môn học và ảnh minh họa.
- **Dải sóng âm động học (`AudioWaveform`):** Mô phỏng biên độ âm thanh bài giảng sống động theo nhịp phát.
- **Thanh tiến trình kéo tua chính xác (`AudioProgressBar`):** Hiển thị thời gian đã phát và tổng thời lượng bài giảng.
- **Điều chỉnh tốc độ nghe:** Chuyển đổi linh hoạt giữa `1.0x`, `1.25x`, `1.5x`, và `2.0x` để tiết kiệm thời gian ôn bài.
- **Hệ thống 3 Tab nội dung:**
  - **Mục Lục (Table of Contents):** Phân đoạn bài học thành các chương mục rõ ràng.
  - **Hỏi Đáp AI (AI Q&A):** Khung chat chuyên sâu với Cú Mèo.
  - **Bản Ghi Chép (Transcript):** Từng đoạn hội thoại kèm nhãn người nói và thẻ ghi chú dán (Sticky Note) đính kèm công thức quan trọng.

### 5. 🔍 Tìm Kiếm Toàn Cục & Lọc Nâng Cao (Global Search)
- Tìm kiếm từ khóa tức thì xuyên suốt tiêu đề bài giảng, môn học, nội dung bản ghi và các câu hỏi AI.
- Gợi ý thẻ tìm kiếm nhanh theo môn học và hiển thị lịch sử từ khóa tìm kiếm gần đây.
- Thẻ lời khuyên học tập dễ thương từ Cú Mèo hướng dẫn cách tra cứu hiệu quả.

### 6. 🔔 Trung Tâm Thông Báo Ôn Tập (Notifications Hub)
- Thông báo tức thì ngay khi bài giảng hoàn tất quá trình phân tích AI.
- Nhắc nhở thông minh ôn lại các điểm trọng tâm trước ngày thi.
- Hỗ trợ đánh dấu đã đọc và điều hướng trực tiếp vào bài giảng liên quan.

### 7. ⚙️ Cá Nhân Hóa & Đổi Chủ Đề Giao Diện (Settings & Dark Mode)
- Hồ sơ sinh viên, thông tin trường đại học và thống kê bài học đã lưu.
- Hỗ trợ chuyển đổi mượt mà giữa chế độ **Sáng (Warm Stationery Paper)** và chế độ **Tối (Pastel Midnight Canvas)** bảo vệ thị giác khi học đêm.

---

## 🛠️ Sơ Đồ Kiến Trúc Phần Mềm & Công Nghệ

Dự án áp dụng mô hình **Feature-First / Layered Architecture** chuẩn công nghiệp:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        MAIN APPLICATION ENTRY                          │
│                           (lib/main.dart)                              │
│              - ProviderScope (Riverpod State Management)               │
│              - MaterialApp.router (GoRouter Navigation Engine)         │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
         ┌──────────────────────────┴──────────────────────────┐
         ▼                                                     ▼
┌─────────────────────────────────┐           ┌─────────────────────────────────┐
│           CORE LAYER            │           │          ROUTER LAYER           │
│         (lib/core/...)          │           │     (lib/core/router/...)       │
├─────────────────────────────────┤           ├─────────────────────────────────┤
│ • Constants (AppConstants)      │           │ • AppRouter Configuration       │
│ • Asset Paths (AssetPaths)      │           │ • Custom Transitions (Fade,     │
│ • Motion Tokens (AppMotionTokens│           │   Auth Shared-Surface, Slide)   │
│ • Theme & Typography (AppTheme) │           │ • 404 Route Protection Fallback │
│ • State Providers (Theme, User) │           │ • Deep Linking Query Support    │
│ • Utilities (Date/Duration)     │           └────────────────┬────────────────┘
└────────────────┬────────────────┘                            │
                 │                                             │
                 └──────────────────────┬──────────────────────┘
                                        ▼
┌────────────────────────────────────────────────────────────────────────┐
│                             FEATURES LAYER                             │
│                           (lib/features/...)                           │
│  Tổ chức độc lập theo từng tính năng nghiệp vụ (Feature-First):        │
│  • splash           • onboarding         • auth (login & register)     │
│  • library          • upload             • processing                  │
│  • lecture_detail   • search             • notifications  • settings   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│                              SHARED LAYER                              │
│                            (lib/shared/...)                            │
│  Tài nguyên dùng chung toàn ứng dụng:                                  │
│  • models:  LectureUiModel, NotificationUiModel, SearchResultUiModel   │
│  • widgets: DotBackground, LlAppBar, LlBottomNavBar, AudioPlayerCapsule│
│             LectureCard, StickyNoteCard, StatusChip, SkeletonBox...    │
└────────────────────────────────────────────────────────────────────────┘
```

### Bảng Công Nghệ & Thư Viện Sử Dụng

| Thư Viện / Công Nghệ | Phiên Bản | Phân Loại | Mục Đích Sử Dụng Trong Dự Án |
| :--- | :--- | :--- | :--- |
| **Flutter SDK** | `>=3.2.0` *(Tested 3.47.x)* | Framework | Nền tảng phát triển ứng dụng di động & web đa nền tảng |
| **Dart SDK** | `3.x` *(Tested 3.13.x)* | Ngôn ngữ | Ngôn ngữ lập trình hiện đại, hướng đối tượng mạnh mẽ, Type-Safe |
| **flutter_riverpod** | `^2.5.1` | State Management | Quản lý trạng thái ứng dụng phản ứng (ThemeMode, Profile, Notifications) |
| **go_router** | `^13.2.0` | Routing | Điều hướng khai báo, deep linking, xử lý 404 và chuyển cảnh tùy chỉnh |
| **flutter_animate** | `^4.5.0` | Motion Animation | Chuỗi vi hoạt ảnh chuyển động, hiệu ứng mờ dần, nảy và bay bổng |
| **google_fonts** | `^6.2.1` | Typography | Tải và kết xuất phông chữ Quicksand (Tiêu đề) và Nunito Sans (Nội dung) |
| **flutter_svg** | `^2.0.10` | Graphic Assets | Kết xuất hình ảnh vector SVG sắc nét trên mọi mật độ điểm ảnh |
| **shimmer** | `^3.0.0` | Visual Effect | Hiệu ứng quét sáng bóng cho các khung xương tải trang (Skeleton Shimmer) |
| **intl** | `^0.19.0` | Internationalization | Định dạng ngày tháng, giờ học và chuẩn hóa chuỗi ngôn ngữ |

---

## 📁 Cấu Trúc Thư Mục Dự Án Chuẩn Mực

Dự án được tái cấu trúc triệt để theo chuẩn **Feature-First / Layered Architecture** với hệ thống Barrel Export sạch sẽ:

```
lecturelens_app/
├── assets/
│   └── svg/
│       ├── logo/
│       │   ├── logo_full.svg             # Logo LectureLens đầy đủ kèm biểu tượng Cú Mèo
│       │   ├── logo_icon.svg             # Biểu tượng icon ứng dụng
│       │   └── logo_splash.svg           # Biểu tượng vector kích thước lớn cho màn hình Splash
│       ├── icons/
│       │   ├── nav/                      # Bộ icon thanh điều hướng: ic_library, ic_search, ic_cu_meo_ai, ic_settings
│       │   ├── actions/                  # Icon tương tác: ic_upload_cloud, ic_bell, ic_play, ic_pause, ic_bookmark...
│       │   └── status/                   # Icon trạng thái: ic_check_circle, ic_processing, ic_error, ic_clock, ic_pin...
│       └── illustrations/                # Tranh minh họa: cu_meo_listening, cu_meo_happy, upload_zone, empty_library
│
├── lib/
│   ├── main.dart                         # Điểm vào chính của ứng dụng (ProviderScope & MaterialApp.router)
│   │
│   ├── core/                             # Lớp cốt lõi hệ thống (Core Layer)
│   │   ├── core.dart                     # 🌟 Barrel export tập trung cho toàn bộ Core Layer
│   │   ├── constants/
│   │   │   ├── app_constants.dart        # Hằng số định danh route, cấu hình giới hạn tệp và thời gian
│   │   │   └── asset_paths.dart          # Quản lý tập trung 100% đường dẫn SVG, logo và biểu tượng
│   │   ├── motion/
│   │   │   └── app_motion_tokens.dart    # Token thời gian hoạt cảnh, độ cong Curves và hệ số nảy xúc giác
│   │   ├── providers/
│   │   │   └── app_state_providers.dart  # Riverpod Providers: ThemeMode, UserProfile, Unread Notifications
│   │   ├── router/
│   │   │   ├── app_router.dart           # Cấu hình GoRouter, hiệu ứng chuyển trang Fade, Slide, Auth Page
│   │   │   └── route_not_found_screen.dart # Màn hình xử lý lỗi điều hướng 404 thân thiện
│   │   ├── theme/
│   │   │   ├── app_colors.dart           # Bảng màu thiết kế Pastel Nhật Bản (Light & Dark tokens)
│   │   │   ├── app_typography.dart       # Cấu hình TextTheme với Quicksand và Nunito Sans
│   │   │   ├── app_spacing.dart          # Chuẩn khoảng cách lề (Spacing tokens: 4px, 8px, 16px, 24px...)
│   │   │   ├── app_shadows.dart          # Hệ thống đổ bóng mềm mại đa cấp độ (Level 1 -> Level 4)
│   │   │   ├── app_border_radius.dart    # Chuẩn bo góc: Card, Button, Chip, Pill
│   │   │   ├── app_scroll_behavior.dart  # Cấu hình cuộn mượt mà không vệt sóng nước trên Web/Desktop
│   │   │   └── app_theme.dart            # Tổng hợp ThemeData cho cả Sáng (Light) và Tối (Dark)
│   │   └── utils/
│   │       ├── date_formatter.dart       # Định dạng mốc thời gian tương đối tiếng Việt (Hôm nay, Hôm qua...)
│   │       └── duration_formatter.dart   # Định dạng thời lượng bài giảng (mm:ss và hh:mm:ss)
│   │
│   ├── shared/                           # Lớp tài nguyên dùng chung (Shared Layer)
│   │   ├── shared.dart                   # 🌟 Barrel export toàn bộ Shared Layer
│   │   ├── models/
│   │   │   ├── models.dart               # Barrel export danh mục models
│   │   │   ├── lecture_ui_model.dart     # Model bài giảng, mục lục, transcript và đoạn chat AI kèm mock data
│   │   │   ├── notification_ui_model.dart# Model dữ liệu thông báo và trạng thái đọc
│   │   │   └── search_result_ui_model.dart # Model kết quả tìm kiếm theo ngữ cảnh bài học
│   │   └── widgets/
│   │       ├── widgets.dart              # Barrel export danh mục shared widgets
│   │       ├── dot_background.dart       # Nền canvas chấm bi sổ tay học tập (CustomPainter)
│   │       ├── ll_app_bar.dart           # Thanh AppBar kính mờ kèm logo, tên người dùng và huy hiệu
│   │       ├── notification_badge.dart   # Nút chuông thông báo có chấm đỏ đếm số lượng tin mới
│   │       ├── audio/
│   │       │   ├── audio_player_capsule.dart # Viên nhộng phát âm thanh hoàn chỉnh
│   │       │   ├── audio_progress_bar.dart   # Thanh tua thời gian kéo trượt mượt mà
│   │       │   └── audio_waveform.dart       # Sóng âm thanh động học phản hồi bài giảng
│   │       ├── buttons/
│   │       │   ├── ll_primary_button.dart    # Nút bấm chính gradient với hiệu ứng nhấn nảy
│   │       │   ├── ll_secondary_button.dart  # Nút bấm phụ viền mềm
│   │       │   └── ll_icon_circle_button.dart# Nút biểu tượng tròn (Bookmark, Share, More)
│   │       ├── cards/
│   │       │   ├── lecture_card.dart         # Thẻ bài giảng hoàn chỉnh đính kèm washi tape và sticky note
│   │       │   ├── processing_card.dart      # Thẻ bài giảng đang xử lý với thanh tiến độ gradient
│   │       │   └── sticky_note_card.dart     # Khối ghi chú vàng bơ xoay nhẹ ±1°
│   │       ├── chips/
│   │       │   ├── status_chip.dart          # Huy hiệu trạng thái (Đã sẵn sàng / Đang xử lý / Lỗi)
│   │       │   ├── subject_chip.dart         # Thẻ tên môn học pastel
│   │       │   └── timestamp_chip.dart       # Thẻ mốc thời gian trích dẫn âm thanh
│   │       ├── inputs/
│   │       │   ├── ll_search_bar.dart        # Ô tìm kiếm bo tròn kèm nút xóa và icon micro
│   │       │   └── ll_text_field.dart        # Ô nhập liệu có nhãn, placeholder và thông báo lỗi
│   │       ├── interactive/
│   │       │   └── ll_pressable.dart         # Widget bọc tương tác nảy xúc giác (Tactile Press Feedback)
│   │       ├── mascot/
│   │       │   ├── cu_meo_widget.dart        # Widget hiển thị Cú Mèo kèm hoạt cảnh thở sinh học
│   │       │   └── cu_meo_empty_state.dart   # Giao diện trống thân thiện khi chưa có dữ liệu
│   │       ├── navigation/
│   │       │   └── ll_bottom_nav_bar.dart    # Thanh điều hướng viên nhộng nổi kính mờ (Frosted Pill)
│   │       ├── skeleton/
│   │       │   ├── skeleton_box.dart         # Hộp hiệu ứng tải khung xương (Shimmer loading box)
│   │       │   ├── lecture_card_skeleton.dart# Khung xương thẻ bài giảng thư viện
│   │       │   └── lecture_detail_skeleton.dart # Khung xương trang chi tiết bài học
│   │       └── washi_tape/
│   │           └── washi_tape_accent.dart    # Họa tiết băng dính trang trí nhiều màu sắc
│   │
│   └── features/                         # Lớp tính năng người dùng (Features Layer)
│       ├── features.dart                 # 🌟 Barrel export cho tất cả màn hình tính năng
│       ├── splash/                       # Màn hình khởi động & trạng thái kết nối
│       │   ├── splash.dart               # 🌟 Barrel export cho toàn bộ màn hình Splash
│       │   ├── splash_screen.dart        # Màn hình Splash chính với vầng sáng halo và Cú Mèo bay
│       │   ├── splash_ai_startup_screen.dart # Màn hình khởi tạo tiến trình AI (0% -> 88%)
│       │   ├── splash_loading_screen.dart    # Màn hình nạp dữ liệu ban đầu
│       │   ├── splash_slow_network_screen.dart # Màn hình xử lý mạng chậm thân thiện
│       │   ├── splash_error_screen.dart      # Màn hình mất kết nối có nút thử lại
│       │   └── splash_subscreens.dart        # Re-export các màn hình phụ splash tương thích
│       ├── onboarding/                   # Hướng dẫn người dùng mới (3 Slides tương tác)
│       │   ├── onboarding_screen.dart    # Trang điều khiển slide, nút bỏ qua và bắt đầu
│       │   ├── onboarding_data.dart      # Dữ liệu hình ảnh và văn bản giới thiệu
│       │   └── widgets/
│       │       ├── onboarding_slide.dart # Giao diện từng trang trình chiếu
│       │       └── onboarding_page_indicator.dart # Đốm chỉ báo trang đang xem
│       ├── auth/                         # Đăng nhập & Đăng ký sinh viên
│       │   ├── auth.dart                 # 🌟 Barrel export cho toàn bộ module xác thực
│       │   ├── login/
│       │   │   ├── login_screen.dart     # Giao diện đăng nhập tài khoản
│       │   │   └── widgets/login_form.dart # Biểu mẫu email, mật khẩu và quên mật khẩu
│       │   └── register/
│       │       ├── register_screen.dart  # Giao diện đăng ký thành viên mới
│       │       └── widgets/register_form.dart # Biểu mẫu họ tên, trường học và mật khẩu
│       ├── library/                      # Thư viện bài giảng (Màn hình chính)
│       │   ├── library_screen.dart       # Quản lý danh sách, cuộn ẩn thanh điều hướng, chế độ xem
│       │   └── widgets/
│       │       ├── library_header.dart   # Lời chào sinh viên và tổng số bài học
│       │       ├── library_filter_tabs.dart # Thanh cuộn lọc bài học theo tab
│       │       └── library_fab.dart      # Nút tải bài giảng nổi tự căn chỉnh cao độ
│       ├── upload/                       # Tải lên file ghi âm bài học
│       │   ├── upload_screen.dart        # Giao diện chọn tệp và điền thông tin môn học
│       │   └── widgets/
│       │       ├── upload_drop_zone.dart # Vùng kéo thả tệp ghi âm sinh động
│       │       └── upload_metadata_form.dart # Nhập tiêu đề bài giảng và thẻ gắn kèm
│       ├── processing/                   # Tiến trình xử lý AI thời gian thực
│       │   ├── processing_screen.dart    # Hiển thị thanh tiến độ tổng quát và ước tính thời gian
│       │   └── widgets/
│       │       └── processing_timeline.dart # Dòng thời gian 4 bước phân tích chi tiết
│       ├── lecture_detail/               # Chi tiết bài học, nghe audio & học tập
│       │   ├── lecture_detail_screen.dart# Bố cục chính với Audio Capsule và 3 tab nội dung
│       │   └── widgets/
│       │       ├── ai_chat_bubble.dart   # Bong bóng chat hỏi đáp AI kèm nút nhảy mốc âm thanh
│       │       ├── transcript_segment.dart# Đoạn hội thoại kèm nhãn thời gian và giấy nhớ
│       │       └── tabs/
│       │           ├── table_of_contents_tab.dart # Danh sách mục lục các chủ đề
│       │           ├── ai_qa_tab.dart    # Tab trò chuyện tương tác với Cú Mèo AI
│       │           └── transcript_tab.dart # Tab đọc văn bản bóc tách từ bài giảng
│       ├── search/                       # Tìm kiếm toàn cục
│       │   ├── search_screen.dart        # Tìm kiếm theo từ khóa và hiển thị kết quả thời gian thực
│       │   └── widgets/
│       │       ├── search_cu_meo_tip.dart# Hộp mẹo tìm kiếm thông minh từ Cú Mèo
│       │       ├── search_recent_chips.dart # Các từ khóa tìm kiếm gần đây
│       │       └── search_result_item.dart  # Thẻ kết quả tìm kiếm có gắn nhãn ngữ cảnh
│       ├── notifications/                # Trung tâm thông báo học tập
│       │   ├── notifications_screen.dart # Danh sách thông báo hoàn tất xử lý và nhắc ôn bài
│       │   └── widgets/
│       │       └── notification_item.dart# Hàng thông báo có biểu tượng và thời gian tương đối
│       └── settings/                     # Thiết lập tài khoản & Giao diện
│           ├── settings_screen.dart      # Quản lý tài khoản, bộ nhớ lưu trữ và thông tin ứng dụng
│           └── widgets/
│               ├── profile_card.dart     # Thẻ hồ sơ cá nhân sinh viên
│               ├── theme_selector.dart   # Bộ chuyển đổi chế độ Sáng / Tối trực quan
│               └── app_info_card.dart    # Phiên bản ứng dụng và liên kết hỗ trợ
│
├── test/                                 # Bộ kiểm thử tự động toàn diện (Test Suite - 32 Tests)
│   ├── motion_and_ux_test.dart           # Kiểm thử AppMotionTokens, LlPressable, CuMeoWidget, AudioProgressBar
│   ├── core/
│   │   ├── providers/
│   │   │   └── app_state_providers_test.dart # Kiểm thử Riverpod Providers (Onboarding, Profile, Notifications)
│   │   ├── router/
│   │   │   └── app_router_test.dart      # Kiểm thử GoRouter danh mục tuyến đường và màn hình báo lỗi 404
│   │   └── utils/
│   │       ├── date_formatter_test.dart  # Kiểm thử logic định dạng ngày tương đối tiếng Việt & chặn lệch giờ
│   │       └── duration_formatter_test.dart # Kiểm thử định dạng mm:ss, hh:mm:ss và chặn duration âm
│   └── shared/
│       └── models/
│           ├── lecture_ui_model_test.dart# Kiểm thử toàn vẹn cấu trúc dữ liệu và mock data bài giảng
│           ├── notification_ui_model_test.dart # Kiểm thử model thông báo và phân loại NotificationType
│           └── search_result_ui_model_test.dart # Kiểm thử model kết quả tra cứu toàn cục
│
├── LICENSE                               # Giấy phép bản quyền mã nguồn mở MIT
├── pubspec.yaml                          # Cấu hình gói thư viện, phông chữ và tài nguyên SVG
├── analysis_options.yaml                 # Cấu hình quy chuẩn phân tích mã tĩnh (Linter rules)
└── README.md                             # Tài liệu kỹ thuật chi tiết của dự án
```

---

## 🗺️ Bảng Định Tuyến & Luồng Điều Hướng (Routing Catalog)

Ứng dụng sử dụng `GoRouter` với các hiệu ứng chuyển cảnh độc quyền:
- **`_buildFadePage`:** Chuyển cảnh mờ dần mềm mại, không gây chớp giật nền.
- **`_buildAuthPage`:** Hiệu ứng Shared-Surface độc quyền giữa Login và Register, phóng to/thu nhỏ nhẹ nhàng và ngăn chặn tình trạng đè mờ bóng chữ (double-exposure).
- **`_buildSlidePage`:** Chuyển cảnh trượt ngang nhẹ (`Offset(0.04, 0)`) hoặc trượt dọc nhẹ (`Offset(0, 0.06)`) tạo chiều sâu phân tầng không gian.

| Tuyến Đường (Path) | Tên Màn Hình (Screen) | Hiệu Ứng Chuyển Cảnh | Mô Tả & Tham Số Bổ Sung |
| :--- | :--- | :--- | :--- |
| `/` | `SplashScreen` | FadeTransition | Chào đón người dùng với linh vật Cú Mèo, halo aura và thanh nạp dữ liệu |
| `/splash-ai` | `SplashAiStartupScreen` | FadeTransition | Mô phỏng tiến trình khởi động AI bóc tách bài học từ 0% lên 88% |
| `/splash-load` | `SplashLoadingScreen` | FadeTransition | Đồng bộ dữ liệu máy chủ LectureLens |
| `/splash-slow` | `SplashSlowNetworkScreen`| FadeTransition | Xử lý mạng chập chờn với thông điệp nhẹ nhàng |
| `/splash-error` | `SplashErrorScreen` | FadeTransition | Mất kết nối internet, hỗ trợ nút bấm *Thử lại ngay* |
| `/onboarding` | `OnboardingScreen` | FadeTransition | 3 slide giới thiệu các tính năng độc đáo cho người dùng mới |
| `/login` | `LoginScreen` | Auth Shared-Surface | Đăng nhập tài khoản sinh viên qua Email & Mật khẩu |
| `/register` | `RegisterScreen` | Auth Shared-Surface | Đăng ký tài khoản kèm chọn trường đại học |
| `/library` | `LibraryScreen` | FadeTransition | Màn hình chính: Quản lý kho bài học, tìm kiếm và lọc tab |
| `/upload` | `UploadScreen` | Slide Up (Vertical) | Kéo thả hoặc chọn tệp âm thanh bài học để gửi lên máy chủ |
| `/processing` | `ProcessingScreen` | Slide Up (Vertical) | Giám sát tiến độ AI xử lý bóc tách âm thanh `extra: {title, subject}` |
| `/lecture/:id` | `LectureDetailScreen` | Slide Right (Horizontal) | Xem chi tiết bài học, nghe audio, mục lục và đọc transcript |
| `/lecture/:id/ai` | `LectureDetailScreen` | Slide Right (Horizontal) | Mở trực tiếp tab Cú Mèo AI Q&A để hỏi đáp bài học (`initialTabIndex = 1`) |
| `/search` | `SearchScreen` | Slide Right (Horizontal) | Tìm kiếm toàn cục với gợi ý môn học và lịch sử gần đây |
| `/notifications` | `NotificationsScreen` | Slide Right (Horizontal) | Xem thông báo hoàn tất phân tích và nhắc nhở ôn thi |
| `/settings` | `SettingsScreen` | Slide Right (Horizontal) | Quản lý tài khoản cá nhân, thông tin app và đổi Dark Mode |
| `errorBuilder` | `RouteNotFoundScreen` | Tự động bắt lỗi 404 | Màn hình thông báo lỗi điều hướng kèm Cú Mèo và nút quay về Thư viện |

---

## 🎨 Hệ Thống Thiết Kế & Design Tokens

### 1. Bảng Màu Thiết Kế (Color Palette Tokens)

#### Chế Độ Sáng (Light Mode - Stationery Warm Paper):
| Token Tên Biến | Mã Hex | Ý Nghĩa Thiết Kế & Vị Trí Áp Dụng |
| :--- | :--- | :--- |
| **`primary`** | `#5445B6` | Tím Indigo đậm — Đại diện cho trí tuệ, biểu tượng thương hiệu chính |
| **`primaryContainer`** | `#6D5FD0` | Tím Pastel rực rỡ — Dành cho nút bấm chính CTA, thanh tiến độ và điểm nhấn |
| **`primaryLight`** | `#E8E5FA` | Tím nhạt phớt — Nền bong bóng chat người dùng, vầng sáng aura |
| **`canvasCream`** | `#FFFAF5` | Kem ấm — Màu nền giấy sổ tay bullet journal độc bản của LectureLens |
| **`dotColor`** | `#EADBCE` | Màu chấm bi — Lưới chấm tròn sổ tay cao cấp |
| **`surfaceCard`** | `#FFFFFF` | Trắng tinh khôi — Nền thẻ bài giảng, thẻ ghi chú và thanh tìm kiếm |
| **`stickyYellow`** | `#FFF1C9` | Giấy ghi nhớ bơ vàng — Nền trích dẫn trọng tâm ôn thi |
| **`butterYellowDark`** | `#8D6B00` | Nâu vàng bơ — Màu chữ hiển thị trên khối ghi chú sticky note |
| **`mintGreen`** | `#D8F3DC` | Xanh bạc hà pastel — Washi tape, trạng thái bài giảng đã sẵn sàng (`Ready`) |
| **`sakuraPink`** | `#FFE5EC` | Hồng hoa anh đào — Washi tape trang trí, điểm nhấn cảm xúc vui tươi |
| **`warning`** | `#E5A800` | Vàng cam — Biểu thị trạng thái bài giảng đang xử lý (`Processing`) |
| **`onSurface`** | `#1C192B` | Tím than đậm — Màu chữ tiêu đề chính, có độ tương phản đạt chuẩn WCAG AAA |
| **`onSurfaceVariant`**| `#76738A` | Xám tím trung tính — Màu chữ nội dung phụ, nhãn thời gian và icon thứ cấp |

#### Chế Độ Tối (Dark Mode - Pastel Midnight Canvas):
| Token Tên Biến | Mã Hex | Ý Nghĩa Thiết Kế & Vị Trí Áp Dụng |
| :--- | :--- | :--- |
| **`darkCanvas`** | `#12111A` | Đen tím huyền bí — Màu nền tổng thể bảo vệ mắt khi học bài ban đêm |
| **`darkSurfaceCard`** | `#1B1926` | Nền thẻ bài giảng ban đêm, có độ tương phản nhẹ so với nền canvas |
| **`darkSurfaceContainer`**| `#252234` | Nền ô nhập liệu và các phần tử phụ trợ ban đêm |
| **`darkPrimary`** | `#9D92F3` | Tím dạ quang dịu mắt — Đảm bảo nổi bật rõ ràng trên nền tối |
| **`darkOnSurface`** | `#EDEBF8` | Trắng ánh tím — Màu chữ đọc ban đêm không gây lóa mắt |

### 2. Hệ Thống Kiểu Chữ (Typography Tokens)

Ứng dụng kết hợp hài hòa hai bộ phông chữ từ Google Fonts:
- **Tiêu đề (Headlines & Titles):** Phông chữ `Quicksand` — Đường nét bo cong tròn trịa ở các góc, mang nét dễ thương, gần gũi, khơi gợi cảm xúc thân thiện.
- **Nội dung & Nhãn (Body & Labels):** Phông chữ `Nunito Sans` — Tỷ lệ hình học cân đối, độ mở ký tự thoáng đãng, tối ưu hóa tối đa cho việc đọc văn bản bài giảng dài mà không mỏi mắt.

```dart
// Ví dụ cấu hình trong AppTypography
headlineLarge: GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)
titleMedium:   GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w700)
bodyLarge:     GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.normal, height: 1.5)
labelSmall:    GoogleFonts.nunitoSans(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.2)
```

### 3. Hệ Thống Đổ Bóng Mềm Mại (Elevation & Shadows)

Không sử dụng đổ bóng gắt mặc định của Material, LectureLens xây dựng 4 cấp độ bóng tản mịn:
- **`level0`:** Hoàn toàn phẳng (Border only).
- **`level1` (Soft Card):** `BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 3))` — Dành cho các thẻ bài giảng trong thư viện.
- **`level2` (Floating Capsule):** `BoxShadow(color: Color(0x1A5445B6), blurRadius: 16, offset: Offset(0, 6))` — Dành cho Audio Capsule và Floating FAB.
- **`level3` (Modal & Pill Bar):** `BoxShadow(color: Color(0x1F1C192B), blurRadius: 24, offset: Offset(0, 8))` — Dành cho Bottom Navigation Bar và Dialogs.

### 4. Hệ Thống Chuyển Động (Motion Design Tokens)

Được định nghĩa tập trung trong `AppMotionTokens`:
- **`micro` (120ms):** Phản hồi chạm nút, đổi trạng thái hover/press.
- **`short` (220ms):** Xuất hiện tooltip, đóng mở dialog, chuyển tab.
- **`medium` (340ms):** Chuyển trang màn hình, trượt danh sách bài giảng.
- **`ambientBreathe` (2400ms):** Nhịp thở sinh học lơ lửng của Cú Mèo AI.
- **`pressScaleFactor` (0.965):** Hệ số thu nhỏ đàn hồi khi người dùng chạm vào phần tử tương tác.

---

## 💻 Yêu Cầu Hệ Thống & Hướng Dẫn Cài Đặt

### Yêu Cầu Tiên Quyết (Prerequisites)
- **Flutter SDK:** Phiên bản `>= 3.2.0` (Khuyến nghị bản Stable mới nhất, đã kiểm thử mượt mà trên Flutter `3.47.x`).
- **Dart SDK:** Phiên bản `>= 3.2.0` (Kèm theo Flutter SDK, đã kiểm thử Dart `3.13.x`).
- **Nền tảng hỗ trợ:**
  - Android: Thiết bị thật hoặc máy ảo chạy Android 7.0 (API Level 24) trở lên.
  - iOS: Máy tính chạy macOS cài sẵn Xcode 15+ (đối với môi trường Apple).
  - Web: Trình duyệt Google Chrome, Edge hoặc Safari phiên bản mới.

### Các Bước Cài Đặt (Quickstart)

1. **Clone mã nguồn dự án về máy tính:**
   ```bash
   git clone https://github.com/your-username/LectureLens.git
   cd LectureLens/lecturelens_app
   ```

2. **Cài đặt toàn bộ các gói thư viện phụ thuộc:**
   ```bash
   flutter pub get
   ```

3. **Kiểm tra tình trạng môi trường làm việc:**
   ```bash
   flutter doctor
   ```

4. **Xác minh mã nguồn và chạy toàn bộ kiểm thử:**
   ```bash
   flutter analyze
   flutter test
   ```
   *(Đảm bảo kết quả trả về `No issues found!` và `All tests passed!`)*

---

## 🏃 Hướng Dẫn Khởi Chạy Ứng Dụng

### 1. Khởi Chạy Trên Thiết Bị Di Động (Android / iOS):
```bash
# Kiểm tra danh sách thiết bị đang kết nối
flutter devices

# Khởi chạy trên thiết bị mặc định
flutter run

# Khởi chạy trên một máy ảo Android cụ thể
flutter run -d emulator-5554
```

### 2. Khởi Chạy Trên Nền Tảng Web (Google Chrome):
```bash
flutter run -d chrome
```

### 3. Phím Tắt Tiện Ích Khi Đang Chạy Chế Độ Debug:
- Nhấn `r`: **Hot Reload** — Cập nhật thay đổi mã giao diện tức thì trong chưa đầy 1 giây.
- Nhấn `R`: **Hot Restart** — Khởi động lại toàn bộ trạng thái State của ứng dụng.
- Nhấn `v`: Mở công cụ giám sát hiệu năng **Flutter DevTools**.
- Nhấn `q`: Thoát phiên chạy gỡ lỗi.

---

## 📦 Hướng Dẫn Build Bản Phát Hành (Release)

### 1. Xuất Bản Android (APK / App Bundle):
```bash
# Tạo file APK cài đặt trực tiếp lên điện thoại Android
flutter build apk --release

# Tệp APK xuất xưởng sẽ nằm tại:
# build/app/outputs/flutter-apk/app-release.apk

# Tạo file Android App Bundle (.aab) để phân phối lên Google Play Store
flutter build appbundle --release
```

### 2. Xuất Bản iOS (Yêu cầu máy tính macOS & chứng chỉ Apple Developer):
```bash
flutter build ipa --release
```

### 3. Xuất Bản Nền Tảng Web:
```bash
flutter build web --release --base-href "/"

# Toàn bộ thư mục sản phẩm tĩnh nằm tại build/web sẵn sàng deploy lên Firebase Hosting, Vercel hoặc Netlify
```

---

## 📝 Quy Chuẩn Lập Trình & Quản Lý Trạng Thái

Để giữ cho dự án luôn trong trẻo, dễ bảo trì và sẵn sàng kết nối với Backend API thực tế, toàn bộ đội ngũ tuân thủ nghiêm ngặt các quy ước sau:

### 1. Quản Lý Trạng Thái Với Riverpod 2.x
- **Tập trung hóa State:** Toàn bộ trạng thái toàn cục (Theme, Hồ sơ sinh viên, Số lượng thông báo) được quản lý qua các `StateNotifierProvider` hoặc `Provider` đặt trong thư mục `lib/core/providers/`.
- **Phân định rõ ràng `ref.watch` và `ref.read`:**
  - Chỉ dùng `ref.watch(...)` bên trong hàm `build(...)` để lắng nghe thay đổi và tái dựng giao diện.
  - Sử dụng `ref.read(...)` bên trong các hàm xử lý sự kiện callback (như `onPressed`, `onTap`) để tránh re-render không cần thiết.
- **Tính bất biến (Immutability):** Dữ liệu state luôn được sao chép thông qua phương thức `.copyWith(...)` và không bao giờ đột biến trực tiếp (no direct mutation).

### 2. Ký Hiệu Chú Thích Đặc Biệt Trong Mã Nguồn
- `// !IMPORTANT`: Đánh dấu các cấu hình kiến trúc cốt lõi tuyệt đối không được phép chỉnh sửa tùy tiện mà không có sự đồng thuận của Lead (ví dụ: `app_colors.dart`, `app_router.dart`, `app_motion_tokens.dart`).
- `// CHỈ DẪN`: Lời giải thích luồng hoạt động chi tiết và chỉ dẫn vị trí chính xác để cắm nối REST API hoặc xử lý logic dữ liệu khi kết nối Backend.

### 3. Tuyệt Đối Không Hardcode Đường Dẫn Asset
- Toàn bộ đường dẫn tới hình ảnh SVG, logo và icon đều phải thông qua các hằng số định nghĩa trong lớp [AssetPaths](file:///d:/02-Projects/LectureLens/lecturelens_app/lib/core/constants/asset_paths.dart).
- Ví dụ chuẩn:
  ```dart
  // ✅ Chuẩn quy ước:
  SvgPicture.asset(AssetPaths.logoFull)
  SvgPicture.asset(AssetPaths.icMic)

  // ❌ Vi phạm quy chuẩn:
  SvgPicture.asset('assets/svg/logo/logo_full.svg')
  ```

### 4. Phòng Ngừa Hiện Tượng Tràn Khung Hình (Overflow-Safe UI)
- Trong mọi khối giao diện chứa văn bản động từ người dùng hoặc API (như tên bài giảng, tóm tắt), bắt buộc bọc `Text` bên trong `Expanded` hoặc `Flexible` kết hợp với `overflow: TextOverflow.ellipsis` và `maxLines` xác định.
- Sử dụng `SingleChildScrollView` với `ClampingScrollPhysics` trên các màn hình biểu mẫu để đảm bảo không bị lỗi tràn pixel khi bàn phím ảo xuất hiện.

### 5. Tiêu Chuẩn Kiểm Thử (Testing Standard)
- Mọi tiện ích định dạng (`DateFormatter`, `DurationFormatter`) và các mô hình dữ liệu (`LectureUiModel`) đều phải có bộ unit test tương ứng trong thư mục `test/`.
- Chạy `flutter test` trước mỗi lần commit mã nguồn để đảm bảo tính toàn vẹn 100%.

---

## 🗺️ Lộ Trình Phát Triển (Roadmap)

- [x] **Giai đoạn 1: Thiết Kế & Trải Nghiệm Người Dùng (Completed)**
  - Hoàn thiện Design System độc quyền phong cách sổ tay Kawaii Study Desk.
  - Xây dựng 21+ màn hình giao diện người dùng mượt mà, responsive trên cả Mobile và Web.
  - Tích hợp hệ thống chuyển động, hoạt cảnh cuộn thông minh và linh vật Cú Mèo đa cảm xúc.
  - Đạt chuẩn phân tích tĩnh `flutter analyze` 0 issues và bộ kiểm thử tự động 32 automated unit & widget tests.
- [ ] **Giai đoạn 2: Tích Hợp Backend & Xử Lý Âm Thanh Thực Tế (In Progress)**
  - Kết nối REST API / GraphQL với máy chủ Backend (FastAPI / Python).
  - Tích hợp thư viện ghi âm trực tiếp từ microphone thiết bị (`record` / `audioplayers`).
  - Triển khai hàng đợi xử lý tệp âm thanh lớn với Celery / Redis.
- [ ] **Giai đoạn 3: Trí Tuệ Nhân Tạo Chuyên Sâu (AI Integration)**
  - Kết nối mô hình Whisper AI Speech-to-Text đa ngôn ngữ (Tiếng Việt & Tiếng Anh chuyên ngành).
  - Tích hợp Gemini 1.5 Pro / Flash API cho trợ lý Cú Mèo Q&A theo thời gian thực.
  - Tự động sinh thẻ ghi chú Flashcards và câu hỏi trắc nghiệm ôn tập nhanh sau mỗi bài học.
- [ ] **Giai đoạn 4: Chia Sẻ & Xuất Bản Dữ Liệu (Collaboration)**
  - Xuất bài giảng và ghi chú sang định dạng PDF, Notion và Markdown.
  - Tính năng chia sẻ thư viện bài giảng theo nhóm học tập và trường đại học.

---

## 🤝 Đóng Góp & Giấy Phép (License)

### Hướng Dẫn Đóng Góp
Mọi đóng góp từ cộng đồng nhằm cải thiện và phát triển **LectureLens** đều được chào đón nồng nhiệt!
1. Fork dự án về tài khoản GitHub của bạn (`Fork repository`).
2. Tạo một nhánh tính năng mới (`git checkout -b feature/TenTinhNangMoi`).
3. Cam kết các thay đổi với thông điệp rõ ràng (`git commit -m 'feat: Them tinh nang ghi am truc tiep'`).
4. Đẩy nhánh lên repository của bạn (`git push origin feature/TenTinhNangMoi`).
5. Mở một **Pull Request** mới và mô tả chi tiết nội dung đã hoàn thành.

### Giấy Phép Sử Dụng
Dự án được phân phối hoàn toàn dưới giấy phép mã nguồn mở **MIT License**. Bạn có thể tự do sử dụng, chỉnh sửa và phân phối cho mục đích học tập cũng như thương mại. Xem chi tiết tại tệp [LICENSE](LICENSE).

---

<p align="center">
  Được sáng tạo và hoàn thiện với tất cả tâm huyết dành cho cộng đồng sinh viên và người học Việt Nam 🇻🇳 🦉📚
</p>
