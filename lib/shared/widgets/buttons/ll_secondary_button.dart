import 'package:flutter/material.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../interactive/ll_pressable.dart';

/// Secondary Button (Nút viền hoặc nền phụ nhẹ nhàng chuẩn Apple HIG có vi tương tác xúc giác)
class LlSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final bool isSuccess;
  final bool isSelected;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const LlSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSuccess = false,
    this.isSelected = false,
    this.width,
    this.height = 44.0,
    this.backgroundColor,
    this.textColor,
  });

  bool get _isEnabled => onPressed != null && !isLoading && !isSuccess;

  @override
  Widget build(BuildContext context) {
    final effectiveBg = backgroundColor ?? (isSelected ? AppColors.primaryLight : AppColors.surfaceContainer);
    final effectiveFg = textColor ?? (isSelected ? AppColors.primaryHover : AppColors.primary);

    return LlPressable(
      onTap: _isEnabled ? onPressed : null,
      scaleFactor: AppMotionTokens.pressScale,
      child: AnimatedContainer(
        duration: AppMotionTokens.short,
        curve: AppMotionTokens.springOut,
        width: (isLoading || isSuccess) ? height : width,
        height: height,
        decoration: BoxDecoration(
          color: _isEnabled
              ? effectiveBg
              : (isSuccess
                  ? AppColors.mintGreenLight
                  : AppColors.outlineVariant.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isSuccess ? AppColors.mintGreenDark : Colors.transparent),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: (isLoading || isSuccess) ? 0 : 20),
          child: Center(
            child: AnimatedSwitcher(
              duration: AppMotionTokens.short,
              switchInCurve: AppMotionTokens.appleSpringCurve,
              child: isLoading
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
                      ),
                    )
                  : isSuccess
                      ? const Icon(
                          Icons.check_rounded,
                          key: ValueKey('success'),
                          color: AppColors.mintGreenDark,
                          size: 20,
                        )
                      : Row(
                          key: const ValueKey('content'),
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icon != null) ...[
                              icon!,
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: Text(
                                text,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: _isEnabled
                                          ? effectiveFg
                                          : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
