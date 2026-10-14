import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';
import '../../shared/widgets/ll_app_bar.dart';
import '../../shared/widgets/mascot/cu_meo_widget.dart';

/// Màn hình báo lỗi 404 / Không tìm thấy trang dành cho GoRouter errorBuilder
class RouteNotFoundScreen extends StatelessWidget {
  final String? errorLocation;

  const RouteNotFoundScreen({
    super.key,
    this.errorLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: LlAppBar(
        title: 'Không tìm thấy trang',
        subtitle: 'Lỗi điều hướng 404',
        showBack: context.canPop(),
        showNotifications: false,
      ),
      body: DotBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CuMeoWidget(
                    variant: CuMeoVariant.sleeping,
                    size: 130,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Trang này đã bay mất rồi! 🦉',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorLocation != null
                        ? 'Không tìm thấy nội dung tại đường dẫn "$errorLocation". Cú Mèo khuyên bạn nên quay lại bàn học chính.'
                        : 'Đường dẫn bạn yêu cầu không tồn tại hoặc đã được di chuyển. Hãy quay lại Thư viện nhé!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 28),
                  LlPrimaryButton(
                    text: 'Về Thư Viện Bài Giảng 📚',
                    width: 260,
                    onPressed: () => context.go(AppConstants.routeLibrary),
                    icon: const Icon(Icons.home_rounded, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
