import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/motion/app_motion_tokens.dart';

/// !IMPORTANT: LlPressable — Widget Phản Hồi Xúc Giác & Đàn Hồi Apple (Apple Tactile Spring Press)
/// CHỈ DẪN: Bọc bất kỳ widget nào (Card, Button, Chip) để tạo cảm giác bấm đàn hồi chuẩn Apple:
/// - Khi nhấn xuống: thu nhỏ còn 0.96 và đổi độ sáng nền (subtle dimming overlay).
/// - Khi thả ra: bật lại bằng spring nảy nhẹ, kèm rung xúc giác tinh tế (light impact).
/// - Khả năng ngắt giữa chừng (interruptible): đảo chiều mượt khi nhả tay hoặc chạm lại.
/// - Đảm bảo khoảng chạm tối thiểu 44x44pt theo Apple HIG khi cần.
/// - Tôn trọng Reduce Motion của hệ thống.
class LlPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleFactor;
  final Duration duration;
  final Curve curve;
  final bool enableHaptic;
  final bool enableOverlay;
  final HitTestBehavior behavior;

  const LlPressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scaleFactor = AppMotionTokens.pressScale,
    this.duration = AppMotionTokens.micro,
    this.curve = AppMotionTokens.springOut,
    this.enableHaptic = true,
    this.enableOverlay = true,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  State<LlPressable> createState() => _LlPressableState();
}

class _LlPressableState extends State<LlPressable> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap == null && widget.onLongPress == null) return;
    setState(() => _isPressed = true);
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!_isPressed) return;
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (!_isPressed) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = AppMotionTokens.shouldReduceMotion(context);
    final targetScale = (!reduceMotion && _isPressed) ? widget.scaleFactor : 1.0;
    final targetOpacity = (reduceMotion && _isPressed) ? 0.75 : 1.0;

    return RepaintBoundary(
      child: GestureDetector(
        behavior: widget.behavior,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedOpacity(
          duration: reduceMotion ? AppMotionTokens.reduceMotionFadeDuration : AppMotionTokens.micro,
          opacity: targetOpacity,
          child: AnimatedScale(
            scale: targetScale,
            duration: widget.duration,
            curve: _isPressed ? Curves.easeOutQuad : widget.curve,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                widget.child,
                if (widget.enableOverlay && _isPressed && !reduceMotion)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: AppMotionTokens.pressOverlayOpacity),
                          borderRadius: BorderRadius.circular(16),
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
