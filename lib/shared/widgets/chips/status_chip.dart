import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../models/lecture_ui_model.dart';

/// Status Chip (Sẵn sàng / Đang xử lý / Lỗi)
class StatusChip extends StatelessWidget {
  final LectureStatus status;
  final double? progress;

  const StatusChip({
    super.key,
    required this.status,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    if (status == LectureStatus.ready) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.mintGreen,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AssetPaths.icCheckCircle,
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                AppColors.mintGreenDark,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Sẵn sàng',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.mintGreenDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    } else if (status == LectureStatus.processing) {
      final percent = ((progress ?? 0.68) * 100).toInt();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.warningContainer,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: AppColors.warning,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Đang xử lý ($percent%)',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.warningDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.softCoral,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AssetPaths.icError,
              width: 14,
              height: 14,
              colorFilter: const ColorFilter.mode(
                AppColors.coralDark,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'Lỗi kết nối',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.coralDark,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }
  }
}
