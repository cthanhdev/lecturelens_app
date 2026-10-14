import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../interactive/ll_pressable.dart';

/// !IMPORTANT: Floating Bottom Navigation Pill (Thanh Điều Hướng Nổi)
/// CHỈ DẪN: Không dùng Scaffold.bottomNavigationBar chuẩn mà dùng Stack nổi
/// kết hợp BackdropFilter làm mờ phía dưới (frosted glass blur 16dp) và vi tương tác tactile.
class LlBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const LlBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: AppShadows.level2,
                    border: Border.all(
                      color: AppColors.outline.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildNavItem(
                        context,
                        index: 0,
                        iconPath: AssetPaths.icNavLibrary,
                        label: 'Thư viện',
                      ),
                      _buildNavItem(
                        context,
                        index: 1,
                        iconPath: AssetPaths.icNavSearch,
                        label: 'Tìm kiếm',
                      ),
                      _buildNavItem(
                        context,
                        index: 2,
                        iconPath: AssetPaths.icNavCuMeoAi,
                        label: 'Cú Mèo AI',
                      ),
                      _buildNavItem(
                        context,
                        index: 3,
                        iconPath: AssetPaths.icNavSettings,
                        label: 'Cài đặt',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required String iconPath,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: LlPressable(
        scaleFactor: 0.94,
        onTap: () => onTabSelected(index),
        child: AnimatedContainer(
          duration: AppMotionTokens.short,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : AppColors.onSurfaceVariant,
                  BlendMode.srcIn,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
