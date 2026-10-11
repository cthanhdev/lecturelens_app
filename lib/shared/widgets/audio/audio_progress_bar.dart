import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/duration_formatter.dart';

/// Audio Progress Scrubber (Thanh tua bài giảng)
class AudioProgressBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final progress = totalDuration.inMilliseconds > 0
        ? (currentPosition.inMilliseconds / totalDuration.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: (details) {
                if (onSeek == null || totalDuration.inMilliseconds == 0) return;
                final dx = details.localPosition.dx.clamp(0.0, constraints.maxWidth);
                final newRatio = dx / constraints.maxWidth;
                final targetMs = (newRatio * totalDuration.inMilliseconds).toInt();
                onSeek!(Duration(milliseconds: targetMs));
              },
              onTapDown: (details) {
                if (onSeek == null || totalDuration.inMilliseconds == 0) return;
                final dx = details.localPosition.dx.clamp(0.0, constraints.maxWidth);
                final newRatio = dx / constraints.maxWidth;
                final targetMs = (newRatio * totalDuration.inMilliseconds).toInt();
                onSeek!(Duration(milliseconds: targetMs));
              },
              child: SizedBox(
                height: 24,
                child: Center(
                  child: Stack(
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
                      // Scrub handle thumb
                      Positioned(
                        left: (constraints.maxWidth * progress - 6).clamp(0.0, constraints.maxWidth - 12),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryContainer,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 4,
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
              DurationFormatter.format(currentPosition),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
            ),
            Text(
              DurationFormatter.format(totalDuration),
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
