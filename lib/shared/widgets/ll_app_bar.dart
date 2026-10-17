import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/motion/app_motion_tokens.dart';
import '../../core/providers/app_state_providers.dart';
import '../../core/theme/app_colors.dart';
import 'interactive/ll_pressable.dart';
import 'notification_badge.dart';

/// !IMPORTANT: App Bar chuẩn của LectureLens (Chuẩn Apple HIG & Theme thích ứng)
/// CHỈ DẪN: Hiển thị Logo Cú Mèo và tên "LectureLens" bên trái,
/// Chuông thông báo và Avatar người dùng bên phải với hiệu ứng kính mờ và màu nền thích ứng Light/Dark.
class LlAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool showBack;
  final bool showLogo;
  final bool showNotifications;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;
  final List<Widget>? actions;

  const LlAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.showLogo = true,
    this.showNotifications = true,
    this.onBackPressed,
    this.onNotificationTap,
    this.onAvatarTap,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final barBgColor = isDark
        ? AppColors.darkCanvas.withValues(alpha: 0.85)
        : AppColors.canvasCream.withValues(alpha: 0.85);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          color: barBgColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side: Back Button or Logo + Title
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showBack)
                      Semantics(
                        label: 'Quay lại',
                        button: true,
                        child: LlPressable(
                          scaleFactor: AppMotionTokens.pressScale,
                          onTap: onBackPressed ??
                              () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.go(AppConstants.routeLibrary);
                                }
                              },
                          child: Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                      )
                    else if (showLogo) ...[
                      SvgPicture.asset(
                        AssetPaths.logoIcon,
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? 'LectureLens',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
                // Right side: Custom actions or Notification + Avatar
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (actions != null) ...actions!,
                    if (showNotifications) ...[
                      NotificationBadge(
                        unreadCount: unreadCount,
                        onTap: onNotificationTap ??
                            () => context.push(AppConstants.routeNotifications),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Semantics(
                      label: 'Hồ sơ người dùng ${userProfile.name}',
                      button: true,
                      child: LlPressable(
                        scaleFactor: AppMotionTokens.pressScale,
                        onTap: onAvatarTap ??
                            () => context.push(AppConstants.routeSettings),
                        child: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          child: Container(
                            width: 38,
                            height: 38,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surfaceContainerHigh,
                              border: Border.all(
                                color: AppColors.primaryContainer.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: ClipOval(
                              child: Container(
                                color: AppColors.primaryLight,
                                child: Center(
                                  child: Text(
                                    userProfile.avatarInitial,
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
