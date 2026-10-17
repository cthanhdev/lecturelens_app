import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import 'interactive/ll_pressable.dart';

/// Bell icon with optional badge count overlay (Chuẩn Apple HIG 44x44pt)
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
    return Semantics(
      label: 'Thông báo, $unreadCount chưa đọc',
      button: true,
      child: LlPressable(
        onTap: onTap,
        scaleFactor: AppMotionTokens.pressScale,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainerLow,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                AssetPaths.icBell,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.onSurface,
                  BlendMode.srcIn,
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE11D48),
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 9,
                      minHeight: 9,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
