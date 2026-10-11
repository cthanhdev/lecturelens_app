import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import 'widgets/app_info_card.dart';
import 'widgets/profile_card.dart';
import 'widgets/theme_selector.dart';

/// !IMPORTANT: Màn Hình Cài Đặt & Hồ Sơ (Settings Screen)
/// CHỈ DẪN: Quản lý thông tin tài khoản sinh viên, chuyển đổi Theme Sáng/Tối,
/// và thông tin phiên bản bản quyền ứng dụng.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      appBar: const LlAppBar(
        title: 'Cài đặt & Hồ sơ',
        subtitle: 'Tùy chỉnh bàn học',
        showBack: true,
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileCard(
                  onLogout: () {
                    context.go(AppConstants.routeLogin);
                  },
                ),
                const SizedBox(height: 16),
                const ThemeSelector(),
                const SizedBox(height: 16),
                const AppInfoCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
