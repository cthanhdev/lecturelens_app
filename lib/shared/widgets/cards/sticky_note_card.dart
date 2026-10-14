import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';

/// !IMPORTANT: Thẻ Ghi Chú Dán (Sticky Note Card)
/// CHỈ DẪN: Màu vàng bơ #FFF1C9, xoay nhẹ ±1° (0.0175 rad), icon đinh ghim,
/// dùng cho trích dẫn trọng tâm ôn thi và ghi chú quan trọng từ AI.
class StickyNoteCard extends StatelessWidget {
  final String title;
  final String content;
  final double rotationAngle; // ví dụ: -0.015 hoặc 0.015
  final int? maxLines;

  const StickyNoteCard({
    super.key,
    this.title = 'Điểm nhấn cốt lõi của bài',
    required this.content,
    this.rotationAngle = -0.012,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6D9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.level3Sticky,
          border: Border.all(
            color: const Color(0xFFFFECC0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AssetPaths.icPin,
                  width: 13,
                  height: 13,
                  colorFilter: const ColorFilter.mode(
                    AppColors.butterYellowPin,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.butterYellowPin,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5,
                        letterSpacing: 0.1,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              content,
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.butterYellowDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                    height: 1.48,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
