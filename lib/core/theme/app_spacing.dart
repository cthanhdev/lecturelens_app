import 'package:flutter/material.dart';

/// Hằng số Spacing theo chuẩn thiết kế Stationery Nhật Bản
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 14.0;
  static const double lg = 20.0;
  static const double xl = 28.0;
  static const double xxl = 36.0;

  // Margin ngang mặc định toàn app
  static const double horizontalMargin = 16.0;

  // Padding helpers
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: horizontalMargin);
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
}
