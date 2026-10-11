import 'package:flutter/material.dart';

/// !IMPORTANT: Hệ thống Shadow mềm mại theo đúng Design Tokens
/// CHỈ DẪN: Tạo hiệu ứng đổ bóng mỏng nhiều lớp (layered soft shadows)
class AppShadows {
  AppShadows._();

  // Level 1: Cards & List items
  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x146D5FD0), // rgba(109, 95, 208, 0.08)
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x0A6D5FD0),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  // Level 2: Floating Audio Player Capsule & Bottom Nav Bar
  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x246D5FD0), // rgba(109, 95, 208, 0.14)
      blurRadius: 28,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0F6D5FD0),
      blurRadius: 10,
      offset: Offset(0, 3),
    ),
  ];

  // Level 3: Sticky notes (Warm amber shadow)
  static const List<BoxShadow> level3Sticky = [
    BoxShadow(
      color: Color(0x145C4813), // rgba(92, 72, 19, 0.08)
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];

  // Primary Button Glowing Shadow
  static const List<BoxShadow> primaryButton = [
    BoxShadow(
      color: Color(0x3D5445B6), // rgba(84, 69, 182, 0.24)
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];
}
