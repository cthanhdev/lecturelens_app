import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_state_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/interactive/ll_spring_switch.dart';
import '../../shared/widgets/ll_app_bar.dart';
import 'widgets/ios_grouped_list.dart';
import 'widgets/profile_card.dart';
import 'widgets/settings_modals.dart';
import 'widgets/theme_selector.dart';

/// !IMPORTANT: Màn Hình Cài Đặt & Hồ Sơ (iOS Grouped Inset Settings Screen)
/// CHỈ DẪN: Bố cục chuẩn Apple HIG với cấu trúc Grouped Inset List:
/// - Header hồ sơ (Avatar, tên, email, nút Chỉnh sửa)
/// - Nhóm 1: Tài khoản (Đổi mật khẩu, Tài khoản liên kết)
/// - Nhóm 2: Tùy chọn (Bật/tắt thông báo, Giao diện Segmented, Ngôn ngữ)
/// - Nhóm 3: Quyền riêng tư & Bảo mật (Quản lý quyền, Khóa ứng dụng Face ID)
/// - Nhóm 4: Trợ giúp & Thông tin (Liên hệ, Điều khoản, Chính sách, Phiên bản)
/// - Nhóm 5: Đăng xuất & Xóa tài khoản 2 bước
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final appLockEnabled = ref.watch(appLockEnabledProvider);
    final selectedLang = ref.watch(selectedLanguageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const LlAppBar(
        title: 'Cài đặt & Hồ sơ',
        subtitle: 'Tùy chỉnh bàn học',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Hồ Sơ Sinh Viên
                const ProfileCard(),
                const SizedBox(height: 24),

                // 2. Nhóm Tài Khoản
                IosGroupedSection(
                  headerTitle: 'Tài khoản',
                  children: [
                    IosGroupedTile(
                      leading: const Icon(Icons.key_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Đổi mật khẩu',
                      subtitle: 'Bảo vệ tài khoản sinh viên',
                      showChevron: true,
                      onTap: () => SettingsModals.showChangePassword(context),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.link_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Tài khoản liên kết',
                      subtitle: 'Google, Apple, Microsoft, GitHub',
                      value: 'Google đã bật',
                      showChevron: true,
                      onTap: () => SettingsModals.showLinkedAccounts(context, ref),
                    ),
                  ],
                ),

                // 3. Nhóm Tùy Chọn
                IosGroupedSection(
                  headerTitle: 'Tùy chọn hiển thị & âm thanh',
                  children: [
                    IosGroupedTile(
                      leading: const Icon(Icons.notifications_active_outlined, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Thông báo đẩy',
                      subtitle: 'Cập nhật tiến độ xử lý & nhắc nhở ôn bài',
                      trailing: LlSpringSwitch(
                        value: notificationsEnabled,
                        semanticsLabel: 'Công tắc thông báo đẩy',
                        onChanged: (val) {
                          ref.read(notificationsEnabledProvider.notifier).state = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.palette_outlined, size: 18, color: AppColors.primary),
                              ),
                              const SizedBox(width: 14),
                              Text(
                                'Giao diện ứng dụng',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const ThemeSelector(),
                        ],
                      ),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.language_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Ngôn ngữ',
                      value: selectedLang,
                      showChevron: true,
                      onTap: () => SettingsModals.showLanguagePicker(context, ref),
                    ),
                  ],
                ),

                // 4. Nhóm Quyền Riêng Tư & Bảo Mật
                IosGroupedSection(
                  headerTitle: 'Quyền riêng tư & Bảo mật',
                  children: [
                    IosGroupedTile(
                      leading: const Icon(Icons.security_rounded, size: 18, color: AppColors.mintGreenDark),
                      leadingBgColor: AppColors.mintGreenLight,
                      title: 'Quản lý quyền ứng dụng',
                      subtitle: 'Microphone, Bộ nhớ, Thông báo',
                      showChevron: true,
                      onTap: () => SettingsModals.showPermissions(context),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.fingerprint_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Khóa ứng dụng',
                      subtitle: 'Yêu cầu Face ID / PIN khi mở app (Stub)',
                      trailing: LlSpringSwitch(
                        value: appLockEnabled,
                        semanticsLabel: 'Khóa ứng dụng bằng Face ID hoặc PIN',
                        onChanged: (val) {
                          ref.read(appLockEnabledProvider.notifier).state = val;
                        },
                      ),
                    ),
                  ],
                ),

                // 5. Nhóm Trợ Giúp & Thông Tin
                IosGroupedSection(
                  headerTitle: 'Trợ giúp & Thông tin',
                  footerText: 'LectureLens — AI Lecture Companion v${AppConstants.appVersion}\nMô hình nhận diện giọng nói tiếng Việt Whisper Large v3',
                  children: [
                    IosGroupedTile(
                      leading: const Icon(Icons.help_outline_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Liên hệ hỗ trợ sinh viên',
                      subtitle: 'support@lecturelens.edu.vn',
                      showChevron: true,
                      onTap: () => SettingsModals.showSupport(context),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.description_outlined, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Điều khoản dịch vụ',
                      showChevron: true,
                      onTap: () => SettingsModals.showTermsAndPrivacy(context, isTerms: true),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.privacy_tip_outlined, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Chính sách bảo mật',
                      showChevron: true,
                      onTap: () => SettingsModals.showTermsAndPrivacy(context, isTerms: false),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.primary),
                      leadingBgColor: isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer,
                      title: 'Phiên bản ứng dụng',
                      value: AppConstants.appVersion,
                    ),
                  ],
                ),

                // 6. Nhóm Hành Động Phá Hủy (Destructive)
                IosGroupedSection(
                  children: [
                    IosGroupedTile(
                      leading: const Icon(Icons.logout_rounded, size: 18, color: Color(0xFFE11D48)),
                      title: 'Đăng xuất',
                      isDestructive: true,
                      onTap: () => SettingsModals.showLogoutConfirm(context),
                    ),
                    IosGroupedTile(
                      leading: const Icon(Icons.delete_forever_rounded, size: 18, color: Color(0xFFE11D48)),
                      title: 'Xóa tài khoản vĩnh viễn',
                      subtitle: 'Xác nhận 2 bước an toàn',
                      isDestructive: true,
                      onTap: () => SettingsModals.showDeleteAccount(context),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
