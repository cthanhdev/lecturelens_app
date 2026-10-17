import 'package:flutter/material.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../interactive/ll_pressable.dart';

/// Circular Icon Button (Bookmark, Share, Mic, Clear, etc.) chuẩn Apple HIG (tối thiểu 44x44pt)
class LlIconCircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double size;
  final String? semanticsLabel;
  final bool isSelected;
  final bool isLoading;

  const LlIconCircleButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.size = 44.0,
    this.semanticsLabel,
    this.isSelected = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      button: true,
      enabled: onPressed != null,
      child: LlPressable(
        onTap: isLoading ? null : onPressed,
        scaleFactor: AppMotionTokens.pressScale,
        child: Container(
          width: size < 44.0 ? 44.0 : size,
          height: size < 44.0 ? 44.0 : size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? (isSelected
                ? AppColors.primaryContainer
                : AppColors.surfaceContainerHigh.withValues(alpha: 0.7)),
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                )
              : icon,
        ),
      ),
    );
  }
}
