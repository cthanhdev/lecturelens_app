import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// !IMPORTANT: Dotted Notebook Canvas — Nền sổ tay chấm bi đặc trưng
/// CHỈ DẪN: CustomPainter vẽ lưới chấm tròn 16px khoảng cách, 1.1px bán kính,
/// tạo cảm giác giấy viết sổ tay Nhật Bản ấm áp tự nhiên.
/// Đã được tối ưu hiệu năng với RepaintBoundary để cô lập lớp vẽ không tốn GPU/CPU khi cuộn hoặc chạy animation.
class DotBackground extends StatelessWidget {
  final Widget child;

  const DotBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Dotted Canvas - Bọc trong RepaintBoundary để cố định layer không repaint lại liên tục
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _DottedPainter(
                dotColor: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : AppColors.dotColor.withValues(alpha: 0.45),
                step: 16.0,
                radius: 1.1,
              ),
            ),
          ),
        ),
        // Content on top
        child,
      ],
    );
  }
}

class _DottedPainter extends CustomPainter {
  final Color dotColor;
  final double step;
  final double radius;

  _DottedPainter({
    required this.dotColor,
    required this.step,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..isAntiAlias = true;

    for (double x = step / 2; x < size.width; x += step) {
      for (double y = step / 2; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedPainter oldDelegate) {
    return oldDelegate.dotColor != dotColor ||
        oldDelegate.step != step ||
        oldDelegate.radius != radius;
  }
}
