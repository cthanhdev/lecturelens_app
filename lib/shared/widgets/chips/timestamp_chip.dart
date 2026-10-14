import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../interactive/ll_pressable.dart';

/// Timestamp Pill Chip ("▶ 12:35" Mint pill để nhảy đến vị trí audio có phản hồi đàn hồi)
class TimestampChip extends StatelessWidget {
  final String timestamp;
  final VoidCallback? onTap;

  const TimestampChip({
    super.key,
    required this.timestamp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LlPressable(
      scaleFactor: 0.92,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.mintGreenLight,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: AppColors.mintGreen.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AssetPaths.icPlay,
              width: 10,
              height: 10,
              colorFilter: const ColorFilter.mode(
                AppColors.mintGreenDark,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              timestamp,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.mintGreenDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
