import 'package:flutter/material.dart';

/// !IMPORTANT: Hệ thống Motion Tokens toàn diện của LectureLens
/// CHỈ DẪN: Quản lý tập trung các thông số thời lượng (durations), đường cong gia tốc (curves)
/// và kiểm tra khả năng tiếp cận (reduced motion) để mang lại cảm giác chạm tự nhiên,
/// mềm mại theo phong cách Stationery & Kawaii Study Desk.
class AppMotionTokens {
  AppMotionTokens._();

  // Durations
  static const Duration micro = Duration(milliseconds: 120);
  static const Duration short = Duration(milliseconds: 220);
  static const Duration medium = Duration(milliseconds: 340);
  static const Duration long = Duration(milliseconds: 480);
  static const Duration pageTransition = Duration(milliseconds: 320);
  static const Duration ambientBreathe = Duration(milliseconds: 2400);

  // Easing Curves
  /// Đường cong đàn hồi nhẹ nhàng khi người dùng bấm vào các thẻ/nút (tactile spring)
  static const Curve springOut = Cubic(0.34, 1.35, 0.64, 1.0);

  /// Đường cong chuyển động mượt mà tự nhiên cho nội dung giao diện vào màn hình
  static const Curve standardEase = Curves.easeOutCubic;

  /// Đường cong chậm dần nhẹ nhàng cho trạng thái thoát (exit)
  static const Curve exitEase = Curves.easeInCubic;

  /// Đường cong điều hòa hình sin cho nhịp thở của mascot hoặc sóng âm
  static const Curve sinePulse = Curves.easeInOutSine;

  /// Scale factor khi nhấn nút/thẻ
  static const double pressScaleFactor = 0.965;

  /// Kiểm tra xem thiết bị của người dùng có đang bật chế độ giảm chuyển động không
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.disableAnimationsOf(context);
  }
}
