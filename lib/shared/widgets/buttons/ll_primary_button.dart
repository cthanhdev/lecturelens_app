import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';

/// !IMPORTANT: Primary Action Pill Button chuẩn Apple Motion
/// CHỈ DẪN: Nút tím bo tròn hình con nhộng (pill), hỗ trợ đầy đủ 5 trạng thái trực quan:
/// default, pressed, disabled, loading, success (icon tích nảy bouncy spring), selected.
class LlPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final bool isSuccess;
  final bool isSelected;
  final double? width;
  final double height;
  final Color? backgroundColor;

  const LlPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSuccess = false,
    this.isSelected = false,
    this.width,
    this.height = 48.0,
    this.backgroundColor,
  });

  @override
  State<LlPrimaryButton> createState() => _LlPrimaryButtonState();
}

class _LlPrimaryButtonState extends State<LlPrimaryButton> {
  bool _isPressed = false;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading && !widget.isSuccess;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = AppMotionTokens.shouldReduceMotion(context);

    // Target width: when loading or success, contract gracefully to a circle/capsule
    final effectiveWidth = widget.isLoading || widget.isSuccess ? widget.height : widget.width;

    return AnimatedScale(
      scale: (_isPressed && _isEnabled && !reduceMotion) ? AppMotionTokens.pressScale : 1.0,
      duration: AppMotionTokens.micro,
      curve: _isPressed ? Curves.easeOutQuad : AppMotionTokens.springOut,
      child: AnimatedContainer(
        duration: AppMotionTokens.short,
        curve: AppMotionTokens.springOut,
        width: effectiveWidth,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: _isEnabled
              ? (widget.backgroundColor != null
                  ? null
                  : const LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primaryContainer,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ))
              : null,
          color: !_isEnabled
              ? (widget.isSuccess
                  ? AppColors.mintGreenDark
                  : (widget.backgroundColor != null
                      ? widget.backgroundColor!.withValues(alpha: 0.4)
                      : AppColors.outlineVariant.withValues(alpha: 0.5)))
              : (widget.backgroundColor ?? (widget.isSelected ? AppColors.primaryHover : null)),
          boxShadow: _isEnabled ? AppShadows.primaryButton : null,
          border: widget.isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onHighlightChanged: (value) {
              if (_isEnabled) {
                setState(() => _isPressed = value);
                if (value) HapticFeedback.lightImpact();
              }
            },
            onTap: _isEnabled ? widget.onPressed : null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (widget.isLoading || widget.isSuccess) ? 0 : 20,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: AppMotionTokens.short,
                  switchInCurve: AppMotionTokens.appleSpringCurve,
                  switchOutCurve: Curves.easeIn,
                  child: widget.isLoading
                      ? const SizedBox(
                          key: ValueKey('loading'),
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : widget.isSuccess
                          ? const Icon(
                              Icons.check_rounded,
                              key: ValueKey('success'),
                              color: Colors.white,
                              size: 22,
                            )
                          : Row(
                              key: const ValueKey('content'),
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.icon != null) ...[
                                  widget.icon!,
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: Text(
                                    widget.text,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: _isEnabled
                                              ? AppColors.onPrimary
                                              : Colors.white.withValues(alpha: 0.7),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
