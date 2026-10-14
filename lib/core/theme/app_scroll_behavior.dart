import 'package:flutter/material.dart';

/// !IMPORTANT: Cấu hình Hành Vi Cuộn Giới Hạn Toàn Ứng Dụng (App Scroll Behavior)
/// CHỈ DẪN: Giới hạn khoảng cuộn, áp dụng ClampingScrollPhysics mặc định trên mọi nền tảng,
/// triệt tiêu hiện tượng kéo nảy vô tận hoặc trôi màn hình ra khoảng trống thừa.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Giữ khung nhìn ổn định, không kéo dãn vỡ tỷ lệ giao diện
    return child;
  }
}
