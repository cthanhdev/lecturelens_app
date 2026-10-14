import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/motion/app_motion_tokens.dart';

/// !IMPORTANT: LlPressable — Widget Phản Hồi Xúc Giác & Co Giãn Đàn Hồi (Tactile Press)
/// CHỈ DẪN: Bọc bất kỳ widget nào (Card, Button, Chip) để tạo cảm giác bấm đàn hồi như
/// ấn vào vật phẩm trên bàn học thật, kèm rung phản hồi tinh tế (Haptic Feedback).
class LlPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleFactor;
  final Duration duration;
  final Curve curve;
  final bool enableHaptic;
  final HitTestBehavior behavior;

  const LlPressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scaleFactor = AppMotionTokens.pressScaleFactor,
    this.duration = AppMotionTokens.micro,
    this.curve = AppMotionTokens.standardEase,
    this.enableHaptic = true,
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
      HapticFeedback.selectionClick();
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

    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedScale(
        scale: targetScale,
        duration: widget.duration,
        curve: _isPressed ? Curves.easeOutQuad : AppMotionTokens.springOut,
        child: widget.child,
      ),
    );
  }
}
