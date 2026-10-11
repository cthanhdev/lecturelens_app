import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';

/// Bell icon with optional badge count overlay
class NotificationBadge extends StatelessWidget {
  final int unreadCount;
  final VoidCallback? onTap;

  const NotificationBadge({
    super.key,
    this.unreadCount = 2,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              AssetPaths.icBell,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.onSurface,
                BlendMode.srcIn,
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE11D48),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
