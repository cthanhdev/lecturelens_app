import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/duration_formatter.dart';

/// Audio Progress Scrubber (Thanh tua bài giảng với phản hồi kéo nở to và rung xúc giác)
class AudioProgressBar extends StatefulWidget {
  final Duration currentPosition;
  final Duration totalDuration;
  final ValueChanged<Duration>? onSeek;

  const AudioProgressBar({
    super.key,
    required this.currentPosition,
    required this.totalDuration,
    this.onSeek,
  });

  @override
  State<AudioProgressBar> createState() => _AudioProgressBarState();
}

class _AudioProgressBarState extends State<AudioProgressBar> {
  bool _isDragging = false;

  void _seekTo(double localX, double maxWidth) {
    if (widget.onSeek == null || widget.totalDuration.inMilliseconds == 0) return;
    final dx = localX.clamp(0.0, maxWidth);
    final newRatio = dx / maxWidth;
    final targetMs = (newRatio * widget.totalDuration.inMilliseconds).toInt();
    widget.onSeek!(Duration(milliseconds: targetMs));
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.totalDuration.inMilliseconds > 0
        ? (widget.currentPosition.inMilliseconds / widget.totalDuration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragStart: (details) {
                setState(() => _isDragging = true);
                HapticFeedback.selectionClick();
                _seekTo(details.localPosition.dx, constraints.maxWidth);
              },
              onHorizontalDragUpdate: (details) {
                _seekTo(details.localPosition.dx, constraints.maxWidth);
              },
              onHorizontalDragEnd: (_) {
                setState(() => _isDragging = false);
              },
              onHorizontalDragCancel: () {
                setState(() => _isDragging = false);
              },
              onTapDown: (details) {
                HapticFeedback.selectionClick();
                _seekTo(details.localPosition.dx, constraints.maxWidth);
              },
              child: SizedBox(
                height: 28,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    children: [
                      // Track background
                      Container(
                        height: 5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      // Progress fill
                      Container(
                        height: 5,
                        width: constraints.maxWidth * progress,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      // Scrub handle thumb with tactile animated expansion
                      Positioned(
                        left: (constraints.maxWidth * progress - (_isDragging ? 9 : 7))
                            .clamp(0.0, constraints.maxWidth - (_isDragging ? 18 : 14)),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 140),
                          curve: Curves.easeOutCubic,
                          width: _isDragging ? 18 : 14,
                          height: _isDragging ? 18 : 14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryContainer,
                              width: _isDragging ? 4 : 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryContainer.withValues(alpha: _isDragging ? 0.35 : 0.15),
                                blurRadius: _isDragging ? 8 : 4,
                                spreadRadius: _isDragging ? 2 : 0,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DurationFormatter.format(widget.currentPosition),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
            ),
            Text(
              DurationFormatter.format(widget.totalDuration),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
