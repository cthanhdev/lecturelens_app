import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/lecture_ui_model.dart';
import '../../../../shared/widgets/chips/timestamp_chip.dart';

/// Tab Mục Lục Thông Minh (Table of Contents Tab)
class TableOfContentsTab extends StatelessWidget {
  final List<LectureTopicItem> topics;
  final ValueChanged<int>? onSeekSeconds;

  const TableOfContentsTab({
    super.key,
    required this.topics,
    this.onSeekSeconds,
  });

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return const Center(child: Text('Đang tạo mục lục thông minh...'));
    }

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: topic.isCompleted ? AppColors.mintGreen : AppColors.outline,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: topic.isCompleted
                      ? AppColors.mintGreen
                      : AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: topic.isCompleted
                      ? const Icon(Icons.check, size: 16, color: AppColors.mintGreenDark)
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  topic.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              TimestampChip(
                timestamp: topic.timestamp,
                onTap: () => onSeekSeconds?.call(topic.startSeconds),
              ),
            ],
          ),
        );
      },
    );
  }
}
