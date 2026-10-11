import 'package:flutter/material.dart';

/// !IMPORTANT: Bảng màu trung tâm của LectureLens (Japanese Stationery & Kawaii Study Desk)
/// CHỈ DẪN: Không bao giờ hardcode mã màu hex trong widget. Luôn dùng AppColors.xxx
/// Khi cần can thiệp màu sắc theo chủ đề hoặc đổi brand, chỉnh sửa trực tiếp tại file này!
class AppColors {
  AppColors._();

  // Primary Violet / Lavender
  // // CHỈ DẪN: Màu thương hiệu chính dùng cho nút bấm chính, links, active state
  static const Color primary = Color(0xFF5445B6);
  static const Color primaryContainer = Color(0xFF6D5FD0);
  static const Color primaryLight = Color(0xFFECE9FB);
  static const Color primaryHover = Color(0xFF4333A4);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Background Canvas (Giấy viết kem pastel Nhật Bản)
  // // CHỈ DẪN: Canvas nền dạng kem ngà ấm áp, kết hợp với dot pattern
  static const Color canvas = Color(0xFFFDF7FF);
  static const Color canvasCream = Color(0xFFFFFAF5);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF2EBFF);
  static const Color surfaceContainerLow = Color(0xFFF8F1FF);
  static const Color surfaceContainerHigh = Color(0xFFEDE4FF);

  // Typography Text Colors
  // // CHỈ DẪN: onSurface dùng cho text chính (tím đen), onSurfaceVariant cho mô tả
  static const Color onSurface = Color(0xFF3B3550);
  static const Color onSurfaceVariant = Color(0xFF7D7893);
  static const Color outline = Color(0xFFEDE8F5);
  static const Color outlineVariant = Color(0xFFC9C4D5);

  // Stationery Accent Colors (Washi Tape & Sticky Notes)
  // // CHỈ DẪN: Hồng hoa anh đào cho washi tape & bookmark
  static const Color sakuraPink = Color(0xFFF8C8D8);
  static const Color sakuraPinkLight = Color(0xFFFFE4E6);
  static const Color onSakuraPink = Color(0xFF7A5562);

  // // CHỈ DẪN: Xanh bạc hà cho timestamp chip, chip sẵn sàng
  static const Color mintGreen = Color(0xFFCFEFE4);
  static const Color mintGreenDark = Color(0xFF1F6B58);
  static const Color mintGreenLight = Color(0xFFE8F8F3);

  // // CHỈ DẪN: Xanh da trời pastel cho chip phân loại môn học
  static const Color skyBlue = Color(0xFFD8E9FB);
  static const Color skyBlueDark = Color(0xFF2D486B);

  // // CHỈ DẪN: Vàng bơ cho Sticky note tóm tắt và trích dẫn trọng tâm
  static const Color butterYellow = Color(0xFFFFF1C9);
  static const Color butterYellowDark = Color(0xFF5C4813);
  static const Color butterYellowPin = Color(0xFFA67814);

  // Alert & Status Colors
  static const Color softCoral = Color(0xFFFBD0CC);
  static const Color coralDark = Color(0xFF9B2C2C);
  static const Color warning = Color(0xFFE5A800);
  static const Color warningContainer = Color(0xFFFFF3D0);
  static const Color warningDark = Color(0xFF78590A);
  static const Color success = Color(0xFF1F6B58);

  // Dotted pattern color
  static const Color dotColor = Color(0xFFEADBCE);

  // Dark Mode Tokens
  // // !IMPORTANT: Bộ màu cho giao diện Dark Mode (Học đêm)
  static const Color darkCanvas = Color(0xFF1E1B2E);
  static const Color darkSurfaceCard = Color(0xFF2A2640);
  static const Color darkSurfaceContainer = Color(0xFF35304F);
  static const Color darkPrimary = Color(0xFFB4A9F5);
  static const Color darkOnSurface = Color(0xFFEAE5F8);
  static const Color darkOnSurfaceVariant = Color(0xFFAFA9C4);
  static const Color darkOutline = Color(0xFF3E3956);
}
