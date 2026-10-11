import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';

enum SplashState {
  loading,
  slow,
  error,
  aiStartup,
}

/// !IMPORTANT: Màn Hình Khởi Động (Splash Screen) Toàn Diện
/// CHỈ DẪN: Bao gồm mascot Cú Mèo, hiệu ứng phát sáng Halo,
/// và hỗ trợ 4 trạng thái khởi động (Đang tải, Mạng chậm, Lỗi mạng, AI khởi động).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  SplashState _currentState = SplashState.loading;
  double _progress = 0.35;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Tự động chuyển màn hình sang Onboarding sau 3 giây (nếu không đổi trạng thái test)
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _currentState == SplashState.loading) {
        context.go(AppConstants.routeOnboarding);
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _switchState(SplashState state) {
    setState(() {
      _currentState = state;
      if (state == SplashState.loading) {
        _progress = 0.45;
      } else if (state == SplashState.slow) {
        _progress = 0.65;
      } else if (state == SplashState.aiStartup) {
        _progress = 0.88;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      body: DotBackground(
        child: SafeArea(
          child: Column(
            children: [
              // State Switcher Bar for Reviewer / Debug
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.outline),
                  ),
                  child: Row(
                    children: [
                      _buildStateTab('1. Tải', SplashState.loading),
                      _buildStateTab('2. Chậm', SplashState.slow),
                      _buildStateTab('3. Lỗi', SplashState.error),
                      _buildStateTab('4. AI', SplashState.aiStartup),
                    ],
                  ),
                ),
              ),

              // Center: Glowing Halo + Mascot + Brand Name
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mascot with gentle float
                    AnimatedBuilder(
                      animation: _floatController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -6 * _floatController.value),
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Soft halo glow
                          Container(
                            width: 190,
                            height: 190,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  AppColors.primaryLight.withOpacity(0.8),
                                  AppColors.sakuraPinkLight.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AssetPaths.logoSplash,
                            width: 170,
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Dynamic State Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: _buildBottomStateContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateTab(String label, SplashState state) {
    final isActive = _currentState == state;
    return Expanded(
      child: GestureDetector(
        onTap: () => _switchState(state),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : AppColors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomStateContent() {
    switch (_currentState) {
      case SplashState.loading:
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                width: 260,
                height: 8,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: AppColors.surfaceContainer,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryContainer),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Đang khởi động...',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Chuẩn bị sổ tay học tập cho bạn',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        );

      case SplashState.slow:
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                width: 260,
                height: 8,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: AppColors.surfaceContainer,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFB7185)),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.hourglass_top, size: 16, color: Color(0xFFFB7185)),
                const SizedBox(width: 6),
                Text(
                  'Kết nối hơi chậm, bạn đợi chút nhé...',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Đang giữ kết nối giảng đường an toàn',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        );

      case SplashState.error:
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.wifi_off, size: 18, color: Color(0xFFE11D48)),
                SizedBox(width: 6),
                Text(
                  'Không kết nối được máy chủ',
                  style: TextStyle(
                    color: Color(0xFF9F1239),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            LlPrimaryButton(
              text: 'Thử lại',
              width: 240,
              onPressed: () => _switchState(SplashState.loading),
              icon: const Icon(Icons.refresh, color: Colors.white, size: 18),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Xem hướng dẫn kiểm tra mạng',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        );

      case SplashState.aiStartup:
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                width: 260,
                height: 8,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: AppColors.surfaceContainer,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryContainer),
                const SizedBox(width: 6),
                Text(
                  'Cú Mèo đang khởi động bộ não AI... 88%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Nạp kiến thức ngôn ngữ tiếng Việt',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        );
    }
  }
}
