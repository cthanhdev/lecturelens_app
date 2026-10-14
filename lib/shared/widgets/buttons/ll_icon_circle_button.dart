import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../interactive/ll_pressable.dart';

/// Circular Icon Button (Bookmark, Share, Mic, Clear, etc.) với phản hồi chạm đàn hồi
class LlIconCircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double size;

  const LlIconCircleButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.size = 38.0,
  });

  @override
  Widget build(BuildContext context) {
    return LlPressable(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surfaceContainerHigh.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
