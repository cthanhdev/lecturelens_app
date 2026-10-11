import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../models/lecture_ui_model.dart';
import '../chips/status_chip.dart';
import '../chips/subject_chip.dart';
import '../washi_tape/washi_tape_accent.dart';

/// !IMPORTANT: Thẻ Bài Giảng Đang Xử Lý (Processing Lecture Card)
/// CHỈ DẪN: Hiển thị thanh tiến trình 68%, trạng thái AI nhận diện giọng nói và nút Hủy
class ProcessingCard extends StatelessWidget {
  final LectureUiModel lecture;
  final VoidCallback? onCancel;

  const ProcessingCard({
    super.key,
    required this.lecture,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercent = (lecture.processingProgress * 100).toInt();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.level1,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Washi tape top-right
          const Positioned(
            top: -6,
            right: 28,
            child: WashiTapeAccent(
              color: WashiTapeColor.mintGreen,
              rotationAngle: 0.04,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Status Chip + Subject Chip
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          StatusChip(
                            status: LectureStatus.processing,
                            progress: lecture.processingProgress,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SubjectChip(label: lecture.subject),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryContainer),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Lecture Title
                Text(
                  lecture.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: AppColors.onSurface,
                      ),
                ),
                const SizedBox(height: 14),
                // Processing Box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 16,
                                color: AppColors.primaryContainer,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Cú Mèo đang lắng nghe & tổng hợp...',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            '$progressPercent%',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: lecture.processingProgress,
                          minHeight: 8,
                          backgroundColor: AppColors.surfaceContainer,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryContainer),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lecture.processingStatusText ?? 'Đang tách chủ đề & lập mục lục...',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            lecture.remainingTimeText ?? '~ 45 giây nữa',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Audio Spec & Cancel Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.audio_file_outlined,
                          size: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lecture.audioFileName ?? 'Bản ghi phòng học (58.4 MB)',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Hủy tác vụ',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
