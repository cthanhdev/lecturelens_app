import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// !IMPORTANT: Hệ thống Motion Tokens toàn diện của LectureLens theo chuẩn Apple Motion Design
/// CHỈ DẪN: Tập hợp MỘT file duy nhất chứa toàn bộ thông số Spring physics, Durations, Curves,
/// và hỗ trợ chế độ tiếp cận Reduce Motion của hệ điều hành.
class AppMotionTokens {
  AppMotionTokens._();

  // ==========================================
  // 1. APPLE SPRING PHYSICS (mass, stiffness, damping)
  // ==========================================

  /// Spring chuẩn (Chuyển màn hình, modal sheet, toggle switch)
  /// mass: 1.0, stiffness: 260.0, damping: 22.0 (Damping ratio ~0.68: nảy nhẹ, êm ái)
  static const SpringDescription standardSpring = SpringDescription(
    mass: 1.0,
    stiffness: 260.0,
    damping: 22.0,
  );

  /// Spring nhanh (Press tactile feedback cho nút, thẻ, chips)
  /// mass: 1.0, stiffness: 400.0, damping: 30.0 (Phản hồi tức thì, không trễ)
  static const SpringDescription fastSpring = SpringDescription(
    mass: 1.0,
    stiffness: 400.0,
    damping: 30.0,
  );

  /// Spring nảy rõ (Thành công, hoàn tất lựa chọn, toggle active)
  /// mass: 1.0, stiffness: 300.0, damping: 16.0 (Damping ratio ~0.46: độ nảy đàn hồi rõ nét)
  static const SpringDescription bouncySpring = SpringDescription(
    mass: 1.0,
    stiffness: 300.0,
    damping: 16.0,
  );

  // ==========================================
  // 2. TACTILE SCALE & FEEDBACK
  // ==========================================

  /// Độ thu nhỏ khi nhấn nút/thẻ theo chuẩn Apple HIG (0.96)
  static const double pressScale = 0.96;

  /// Giữ tương thích ngược với các test hiện có
  static const double pressScaleFactor = 0.965;

  /// Độ tối màu/phủ nền khi nhấn (Press overlay opacity)
  static const double pressOverlayOpacity = 0.05;

  // ==========================================
  // 3. LIST STAGGER CONSTANTS
  // ==========================================

  /// Độ trễ tối đa giữa các item trong danh sách (tối đa 40ms)
  static const Duration listStaggerDelay = Duration(milliseconds: 35);

  /// Số item tối đa được áp dụng hiệu ứng stagger khi xuất hiện (8 item đầu)
  static const int listStaggerMaxItems = 8;

  // ==========================================
  // 4. FALLBACK DURATIONS (Tương thích ngược & Reduce Motion)
  // ==========================================

  static const Duration micro = Duration(milliseconds: 120);
  static const Duration short = Duration(milliseconds: 220);
  static const Duration medium = Duration(milliseconds: 340);
  static const Duration long = Duration(milliseconds: 480);
  static const Duration pageTransition = Duration(milliseconds: 320);
  static const Duration ambientBreathe = Duration(milliseconds: 2400);

  /// Thời lượng fade ngắn thay thế khi bật Reduce Motion
  static const Duration reduceMotionFadeDuration = Duration(milliseconds: 150);

  // ==========================================
  // 5. EASING CURVES (Cubic fallbacks)
  // ==========================================

  static const Curve springOut = Cubic(0.34, 1.35, 0.64, 1.0);
  static const Curve standardEase = Curves.easeOutCubic;
  static const Curve exitEase = Curves.easeInCubic;
  static const Curve sinePulse = Curves.easeInOutSine;

  // ==========================================
  // 6. HELPER METHODS
  // ==========================================

  /// Kiểm tra xem thiết bị của người dùng có đang bật chế độ giảm chuyển động không
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.disableAnimationsOf(context);
  }

  /// Tạo một SpringSimulation với các tham số Apple
  static SpringSimulation createSpringSimulation({
    required SpringDescription spring,
    double start = 0.0,
    double end = 1.0,
    double velocity = 0.0,
  }) {
    return SpringSimulation(spring, start, end, velocity);
  }

  /// Tạo một Curve dạng Spring chuẩn Apple (dùng cho CurvedAnimation hoặc animate() flutter_animate)
  static const Curve appleSpringCurve = Cubic(0.18, 0.89, 0.32, 1.28);
}
