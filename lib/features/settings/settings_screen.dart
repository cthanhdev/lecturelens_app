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

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppColors.outline),
        ),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Color(0xFFE11D48), size: 22),
            SizedBox(width: 8),
            Text(
              'Đăng xuất tài khoản',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
        content: const Text(
          'Bạn có chắc chắn muốn đăng xuất khỏi LectureLens? Tất cả bài giảng đã lưu trữ vẫn sẽ an toàn trên thiết bị của bạn.',
          style: TextStyle(fontSize: 14, height: 1.4, color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text(
              'Ở lại học tiếp',
              style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE11D48),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              context.go(AppConstants.routeLogin);
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                ProfileCard(
                  onLogout: () => _confirmLogout(context),
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
