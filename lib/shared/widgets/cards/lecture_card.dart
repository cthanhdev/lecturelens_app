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
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: Status Chip + Subject Tag + Bookmark Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            StatusChip(status: lecture.status),
                            const SizedBox(width: 8),
                            SubjectChip(label: '${lecture.subject} • ${lecture.university}'),
                          ],
                        ),
                        GestureDetector(
                          onTap: onBookmarkTap,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              shape: BoxShape.circle,
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
                    const SizedBox(height: 12),
                    // Lecture Title
                    Text(
                      lecture.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: AppColors.onSurface,
                            height: 1.35,
                          ),
                    ),
                    // Sticky note citation snippet if available
                    if (lecture.stickySnippet != null) ...[
                      const SizedBox(height: 12),
                      StickyNoteCard(
                        title: 'Điểm nhấn cốt lõi của bài',
                        content: '“${lecture.stickySnippet!}”',
                      ),
                    ],
                    const SizedBox(height: 12),
                    // Metrics Row (Duration, Topics, Time)
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AssetPaths.icClock,
                              width: 14,
                              height: 14,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DurationFormatter.formatMinutes(lecture.durationSeconds),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColors.outlineVariant,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${lecture.topicsCount} chủ đề',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColors.outlineVariant,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          lecture.relativeTime,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Action Footer Row
                    Row(
                      children: [
                        // Resume audio button
                        Expanded(
                          child: GestureDetector(
                            onTap: onPlayResumeTap ?? onTap,
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainer,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryContainer,
                                          shape: BoxShape.circle,
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
                                      const SizedBox(width: 8),
                                      Text(
                                        lecture.resumePositionSeconds != null
                                            ? 'Nghe tiếp từ ${DurationFormatter.format(Duration(seconds: lecture.resumePositionSeconds!))}'
                                            : 'Nghe bài giảng',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Phần 2',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: AppColors.primary.withOpacity(0.7),
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Note icon button
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.description_outlined,
                                size: 18,
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
