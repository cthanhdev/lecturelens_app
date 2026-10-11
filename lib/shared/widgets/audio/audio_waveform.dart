import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Animated Waveform Bars (Sóng âm thanh học tập)
class AudioWaveform extends StatefulWidget {
  final bool isPlaying;
  final int barCount;
  final double height;
  final Color? barColor;

  const AudioWaveform({
    super.key,
    this.isPlaying = true,
    this.barCount = 28,
    this.height = 36.0,
    this.barColor,
  });

  @override
  State<AudioWaveform> createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveform> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant AudioWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: _WaveformPainter(
            progress: _controller.value,
            barCount: widget.barCount,
            isPlaying: widget.isPlaying,
            color: widget.barColor ?? AppColors.primaryContainer,
          ),
        );
      },
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double progress;
  final int barCount;
  final bool isPlaying;
  final Color color;

  _WaveformPainter({
    required this.progress,
    required this.barCount,
    required this.isPlaying,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    final barSpacing = size.width / barCount;

    for (int i = 0; i < barCount; i++) {
      final x = i * barSpacing + barSpacing / 2;
      // Generate pleasant rhythmic heights
      double baseHeight = sin(i * 0.45) * 0.4 + 0.5;
      if (isPlaying) {
        final dynamicFactor = sin(progress * 2 * pi + i * 0.3) * 0.25;
        baseHeight = (baseHeight + dynamicFactor).clamp(0.15, 0.95);
      }
      final barHeight = size.height * baseHeight;
      final yTop = (size.height - barHeight) / 2;
      final yBottom = yTop + barHeight;

      canvas.drawLine(Offset(x, yTop), Offset(x, yBottom), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isPlaying != isPlaying;
  }
}
