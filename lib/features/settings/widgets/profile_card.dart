import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/app_state_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/ll_secondary_button.dart';
import 'settings_modals.dart';

/// !IMPORTANT: Thẻ Hồ Sơ Sinh Viên (Apple Profile Header Card)
/// CHỈ DẪN: Hiển thị avatar tròn, thông tin tài khoản sinh viên và nút Chỉnh sửa hồ sơ
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceCard : AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppColors.darkOutline : AppColors.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
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
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displaySchool,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displayEmail,
                      style: TextStyle(
                        color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action row: Edit Profile
          SizedBox(
            width: double.infinity,
            child: LlSecondaryButton(
              height: 44,
              icon: const Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
              text: 'Chỉnh sửa hồ sơ',
              onPressed: () => SettingsModals.showEditProfile(context, ref),
            ),
          ),
        ],
      ),
    );
  }
}
