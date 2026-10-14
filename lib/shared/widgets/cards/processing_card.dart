import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../models/lecture_ui_model.dart';
import '../chips/status_chip.dart';
import '../chips/subject_chip.dart';
import '../interactive/ll_pressable.dart';
import '../washi_tape/washi_tape_accent.dart';

/// !IMPORTANT: Thẻ Bài Giảng Đang Xử Lý (Processing Lecture Card)
/// CHỈ DẪN: Hiển thị thanh tiến trình tự động chạy sống động, trạng thái AI nhận diện giọng nói và nút Hủy
class ProcessingCard extends StatefulWidget {
  final LectureUiModel lecture;
  final VoidCallback? onCancel;

  const ProcessingCard({
    super.key,
    required this.lecture,
    this.onCancel,
  });

  @override
  State<ProcessingCard> createState() => _ProcessingCardState();
}

class _ProcessingCardState extends State<ProcessingCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _anim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final currentProgress = widget.lecture.processingProgress * _anim.value;
        final progressPercent = (currentProgress * 100).toInt();

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.outline.withValues(alpha: 0.7),
              width: 1,
            ),
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
            padding: const EdgeInsets.all(20),
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
                            progress: currentProgress,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SubjectChip(
                              label: widget.lecture.subject,
                              secondaryLabel: widget.lecture.university,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
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
                const SizedBox(height: 14),

                // Lecture Title
                Text(
                  widget.lecture.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17.5,
                        color: AppColors.onSurface,
                        height: 1.38,
                        letterSpacing: -0.2,
                      ),
                ),
                const SizedBox(height: 16),

                // Processing Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                      // Animated Progress Bar
                      Container(
                        width: double.infinity,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: currentProgress.clamp(0.0, 1.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primaryContainer,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.lecture.processingStatusText ?? 'Đang tách chủ đề & lập mục lục...',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                          ),
                          Text(
                            widget.lecture.remainingTimeText ?? '~ 45 giây nữa',
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
                          widget.lecture.audioFileName ?? 'Bản ghi phòng học (58.4 MB)',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    LlPressable(
                      scaleFactor: 0.92,
                      onTap: widget.onCancel,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(
                          'Hủy tác vụ',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
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
      },
    );
  }
}
