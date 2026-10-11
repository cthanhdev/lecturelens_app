import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';

/// Màn hình Splash: Đang Tải (Network Check)
class SplashLoadingScreen extends StatelessWidget {
  const SplashLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      body: DotBackground(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetPaths.logoSplash, width: 150, height: 180),
                const SizedBox(height: 24),
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryContainer),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Đang kiểm tra kết nối...',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Màn hình Splash: Mạng Chậm
class SplashSlowNetworkScreen extends StatelessWidget {
  const SplashSlowNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      body: DotBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetPaths.logoSplash, width: 140, height: 170),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warningContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.warning.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.hourglass_top, color: AppColors.warning, size: 28),
                        const SizedBox(height: 8),
                        Text(
                          'Kết nối mạng hơi chậm...',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.warningDark,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cú Mèo vẫn đang cố gắng kết nối tới kho bài giảng.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
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

/// Màn hình Splash: Lỗi Kết Nối
class SplashErrorScreen extends StatelessWidget {
  final VoidCallback? onRetry;

  const SplashErrorScreen({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      body: DotBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetPaths.logoSplash, width: 140, height: 170),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.softCoral.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.coralDark.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.wifi_off_rounded, color: AppColors.coralDark, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'Không thể kết nối máy chủ',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.coralDark,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Vui lòng kiểm tra lại Wi-Fi hoặc 4G/5G của bạn nhé.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  LlPrimaryButton(
                    text: 'Thử lại ngay',
                    width: 220,
                    onPressed: onRetry ?? () => Navigator.of(context).pop(),
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
