import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/lecture_ui_model.dart';
import '../../../shared/widgets/cards/sticky_note_card.dart';
import '../../../shared/widgets/chips/timestamp_chip.dart';

/// Đoạn bản ghi bài giảng (Transcript Segment)
/// Chứa mốc thời gian mint pill, người nói, nội dung văn bản và Sticky note trọng tâm
class TranscriptSegmentWidget extends StatelessWidget {
  final TranscriptSegment segment;
  final VoidCallback? onSeek;

  const TranscriptSegmentWidget({
    super.key,
    required this.segment,
    this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: segment.isKeyPoint
              ? AppColors.primaryLight
              : AppColors.outline.withOpacity(0.7),
          width: segment.isKeyPoint ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Speaker & Timestamp Pill Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    segment.speaker,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                ],
              ),
              TimestampChip(
                timestamp: segment.timestamp,
                onTap: onSeek,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Content text with diacritic safety (line-height >= 1.5)
          Text(
            segment.content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: AppColors.onSurface,
                ),
          ),
          // Sticky Note highlight if present
          if (segment.stickyNoteText != null) ...[
            const SizedBox(height: 14),
            StickyNoteCard(
              title: 'Trọng tâm ôn thi 📌',
              content: segment.stickyNoteText!,
              rotationAngle: 0.015,
            ),
          ],
        ],
      ),
    );
  }
}
