import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/utils/duration_formatter.dart';
import '../../models/lecture_ui_model.dart';
import '../chips/status_chip.dart';
import '../chips/subject_chip.dart';
import '../washi_tape/washi_tape_accent.dart';
import '../interactive/ll_pressable.dart';
import 'sticky_note_card.dart';

/// !IMPORTANT: Thẻ Bài Giảng Hoàn Chỉnh (Ready Lecture Card)
/// CHỈ DẪN: Thẻ chính trong màn hình Thư viện. Chứa Washi tape, nút Lưu bài,
/// đoạn trích dẫn vàng Sticky note, thông số thời lượng & nút nghe tiếp.
class LectureCard extends StatelessWidget {
  final LectureUiModel lecture;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onPlayResumeTap;

  const LectureCard({
    super.key,
    required this.lecture,
    this.onTap,
    this.onBookmarkTap,
    this.onPlayResumeTap,
  });

  @override
  Widget build(BuildContext context) {
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
          // Washi tape accent on top
          const Positioned(
            top: -6,
            right: 32,
            child: WashiTapeAccent(
              color: WashiTapeColor.sakuraPink,
              rotationAngle: -0.03,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: Status Chip + Subject Tag + Bookmark Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              StatusChip(status: lecture.status),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SubjectChip(
                                  label: lecture.subject,
                                  secondaryLabel: lecture.university,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        LlPressable(
                          scaleFactor: 0.88,
                          onTap: onBookmarkTap,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: lecture.isBookmarked
                                  ? AppColors.sakuraPinkLight.withValues(alpha: 0.6)
                                  : AppColors.surfaceContainerLow,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: lecture.isBookmarked
                                    ? AppColors.sakuraPink
                                    : AppColors.outline.withValues(alpha: 0.6),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AssetPaths.icBookmark,
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  lecture.isBookmarked
                                      ? AppColors.primary
                                      : AppColors.onSurfaceVariant,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Lecture Title
                    Text(
                      lecture.title,
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

                    // Sticky note citation snippet if available
                    if (lecture.stickySnippet != null) ...[
                      const SizedBox(height: 14),
                      StickyNoteCard(
                        title: 'Điểm nhấn cốt lõi của bài',
                        content: '“${lecture.stickySnippet!}”',
                        maxLines: 2,
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Metrics Row (Structured scannable tokens)
                    Row(
                      children: [
                        // Duration Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                AssetPaths.icClock,
                                width: 12,
                                height: 12,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 4.5),
                              Text(
                                DurationFormatter.formatMinutes(lecture.durationSeconds),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                      fontSize: 11.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Topics count
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.menu_book_rounded,
                              size: 13,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${lecture.topicsCount} chủ đề',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),

                        // Bullet separator
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColors.outlineVariant,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Relative timestamp
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 13,
                              color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              lecture.relativeTime,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Action Footer Row
                    Row(
                      children: [
                        // Resume audio capsule button with Hero animation
                        Expanded(
                          child: Hero(
                            tag: 'audio_capsule_${lecture.id}',
                            child: Material(
                              type: MaterialType.transparency,
                              child: LlPressable(
                                scaleFactor: 0.97,
                                onTap: onPlayResumeTap ?? onTap,
                                child: Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainer,
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: AppColors.primaryContainer.withValues(alpha: 0.12),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 26,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryContainer,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.primaryContainer.withValues(alpha: 0.28),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                AssetPaths.icPlay,
                                                width: 10,
                                                height: 10,
                                                colorFilter: const ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 9),
                                          Text(
                                            lecture.resumePositionSeconds != null
                                                ? 'Nghe tiếp từ ${DurationFormatter.format(Duration(seconds: lecture.resumePositionSeconds!))}'
                                                : 'Nghe bài giảng',
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                        decoration: BoxDecoration(
                                          color: AppColors.surfaceCard,
                                          borderRadius: BorderRadius.circular(999),
                                          border: Border.all(
                                            color: AppColors.primary.withValues(alpha: 0.1),
                                            width: 0.8,
                                          ),
                                        ),
                                        child: Text(
                                          'Phần 2',
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Note icon button
                        LlPressable(
                          scaleFactor: 0.9,
                          onTap: onTap,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.description_outlined,
                                size: 19,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
