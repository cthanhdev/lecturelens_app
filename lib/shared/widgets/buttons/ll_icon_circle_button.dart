import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Circular Icon Button (Bookmark, Share, Mic, Clear, etc.)
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
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceContainerHigh.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
