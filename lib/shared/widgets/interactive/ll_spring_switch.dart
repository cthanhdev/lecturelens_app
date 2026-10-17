import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';

/// !IMPORTANT: LlSpringSwitch — Công Tắc Trượt Bằng Spring Physics Kiểu iOS
/// CHỈ DẪN: Tuân thủ quy tắc button_feedback_rules:
/// - Núm trượt di chuyển bằng spring physics nhẹ nhàng.
/// - Màu track (đường ray) nội suy mượt giữa tắt (off) và bật (on).
/// - Khoảng chạm bao ngoài đạt tối thiểu 44x44pt chuẩn Apple.
/// - Phản hồi xúc giác tinh tế (light impact) khi gạt.
class LlSpringSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? semanticsLabel;

  const LlSpringSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.semanticsLabel,
  });

  @override
  State<LlSpringSwitch> createState() => _LlSpringSwitchState();
}

class _LlSpringSwitchState extends State<LlSpringSwitch> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reduceMotion = AppMotionTokens.shouldReduceMotion(context);

    final effectiveActiveColor = widget.activeColor ?? AppColors.primary;
    final effectiveInactiveColor = widget.inactiveColor ??
        (isDark ? const Color(0xFF39354F) : const Color(0xFFE2DCED));

    final isEnabled = widget.onChanged != null;

    // Dimensions: iOS Switch Standard is 51x31 with a 27pt knob
    const double width = 51.0;
    const double height = 31.0;
    const double knobSize = 27.0;
    const double padding = 2.0;

    return Semantics(
      label: widget.semanticsLabel,
      toggled: widget.value,
      enabled: isEnabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          if (isEnabled) setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          if (isEnabled) setState(() => _isPressed = false);
        },
        onTapCancel: () {
          if (isEnabled) setState(() => _isPressed = false);
        },
        onTap: isEnabled
            ? () {
                HapticFeedback.lightImpact();
                widget.onChanged!(!widget.value);
              }
            : null,
        child: Container(
          width: 56,
          height: 44, // 44pt minimum touch target
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: reduceMotion ? AppMotionTokens.reduceMotionFadeDuration : AppMotionTokens.short,
            curve: Curves.easeInOut,
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: isEnabled
                  ? (widget.value ? effectiveActiveColor : effectiveInactiveColor)
                  : effectiveInactiveColor.withValues(alpha: 0.5),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: reduceMotion ? AppMotionTokens.reduceMotionFadeDuration : AppMotionTokens.short,
                  curve: AppMotionTokens.appleSpringCurve,
                  alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: padding),
                    child: AnimatedContainer(
                      duration: AppMotionTokens.micro,
                      curve: Curves.easeOut,
                      width: _isPressed ? knobSize + 4 : knobSize,
                      height: knobSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 3,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
