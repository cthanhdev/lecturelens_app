import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/app_state_providers.dart';
import '../../../../core/theme/app_colors.dart';

/// Thẻ Hồ Sơ Sinh Viên
class ProfileCard extends ConsumerWidget {
  final String? name;
  final String? email;
  final String? school;
  final VoidCallback? onLogout;

  const ProfileCard({
    super.key,
    this.name,
    this.email,
    this.school,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final displayName = name ?? profile.name;
    final displayEmail = email ?? profile.email;
    final displaySchool = school ?? profile.school;
    final initial = profile.avatarInitial;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withOpacity(0.24),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                        fontSize: 16,
                      ),
                ),
                Text(
                  displaySchool,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                ),
                Text(
                  displayEmail,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, size: 20),
            color: AppColors.coralDark,
            tooltip: 'Đăng xuất',
            onPressed: onLogout,
          ),
        ],
      ),
    );
  }
}
