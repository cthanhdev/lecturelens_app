import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/providers/app_state_providers.dart';
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
/// CHỈ DẪN: Mascot Cú Mèo bay bổng mượt mà, thanh tiến trình tự động chạy sống động
/// từ 0% đến 100% với hiệu ứng ánh sáng gradient & cập nhật trạng thái thời gian thực.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  SplashState _currentState = SplashState.loading;

  // Mascot Floating & Halo Animation
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  // Dynamic Running Progress Bar Animation
  late final AnimationController _progressController;
  late final Animation<double> _progressAnimation;

  // Shimmer Wave Light on Progress Bar
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    // 1. Floating mascot animation (smooth sinusoidal harmonic float)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);

    _floatAnimation = CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOutSine,
    );

    // 2. Shimmer sweep on the progress indicator
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    // 3. Dynamic progress bar (Chạy từ 0% đến 100% cực kỳ mượt mà)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2700),
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    );

    _progressController.addStatusListener(_onProgressStatusChanged);

    // Bắt đầu chạy tiến trình ngay khi khởi động
    _progressController.forward();
  }

  void _onProgressStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed &&
        mounted &&
        _currentState == SplashState.loading) {
      final hasCompleted = ref.read(hasCompletedOnboardingProvider);
      if (hasCompleted) {
        context.go(AppConstants.routeLogin);
      } else {
        context.go(AppConstants.routeOnboarding);
      }
    }
  }

  @override
  void dispose() {
    _progressController.removeStatusListener(_onProgressStatusChanged);
    _floatController.dispose();
    _progressController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _switchState(SplashState state) {
    setState(() {
      _currentState = state;
    });

    if (state == SplashState.loading) {
      _progressController.reset();
      _progressController.forward();
    } else if (state == SplashState.slow) {
      _progressController.animateTo(
        0.65,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
      );
    } else if (state == SplashState.aiStartup) {
      _progressController.animateTo(
        0.88,
        duration: const Duration(milliseconds: 1400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DotBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Center: Glowing Halo + Mascot + Brand Name
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mascot with gentle sinusoidal float
                    AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -8 * _floatAnimation.value),
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Soft pulsing halo glow
                          AnimatedBuilder(
                            animation: _floatAnimation,
                            builder: (context, child) {
                              final glowScale = 0.95 + 0.1 * _floatAnimation.value;
                              return Transform.scale(
                                scale: glowScale,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        AppColors.primaryLight.withValues(alpha: 0.85),
                                        AppColors.sakuraPinkLight.withValues(alpha: 0.45),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SvgPicture.asset(
                            AssetPaths.logoSplash,
                            width: 175,
                            height: 205,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Dynamic State Container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: _buildBottomStateContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomStateContent() {
    switch (_currentState) {
      case SplashState.loading:
        return AnimatedBuilder(
          animation: Listenable.merge([_progressAnimation, _shimmerController]),
          builder: (context, _) {
            final progressVal = _progressAnimation.value.clamp(0.0, 1.0);
            final percent = (progressVal * 100).toInt();

            String statusTitle = 'Đang khởi động... $percent%';
            String statusSubtitle = 'Chuẩn bị sổ tay học tập cho bạn';

            if (progressVal >= 0.35 && progressVal < 0.70) {
              statusTitle = 'Nạp bài giảng & AI... $percent%';
              statusSubtitle = 'Tối ưu hóa bộ nhớ giọng nói và ghi chú';
            } else if (progressVal >= 0.70 && progressVal < 0.95) {
              statusTitle = 'Đồng bộ hóa bàn học... $percent%';
              statusSubtitle = 'Cú Mèo đang chuẩn bị bài học hôm nay';
            } else if (progressVal >= 0.95) {
              statusTitle = 'Sẵn sàng! 100%';
              statusSubtitle = 'Chúc bạn một buổi học đầy cảm hứng ✨';
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActiveProgressBar(
                  value: progressVal,
                  barColor: AppColors.primaryContainer,
                  shimmerProgress: _shimmerController.value,
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
                      statusTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    statusSubtitle,
                    key: ValueKey(statusSubtitle),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            );
          },
        );

      case SplashState.slow:
        return AnimatedBuilder(
          animation: Listenable.merge([_progressAnimation, _shimmerController]),
          builder: (context, _) {
            final progressVal = _progressAnimation.value.clamp(0.0, 1.0);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActiveProgressBar(
                  value: progressVal,
                  barColor: const Color(0xFFFB7185),
                  shimmerProgress: _shimmerController.value,
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
          },
        );

      case SplashState.error:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              text: 'Thử lại ngay',
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
        return AnimatedBuilder(
          animation: Listenable.merge([_progressAnimation, _shimmerController]),
          builder: (context, _) {
            final progressVal = _progressAnimation.value.clamp(0.0, 1.0);
            final percent = (progressVal * 100).toInt();

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildActiveProgressBar(
                  value: progressVal,
                  barColor: AppColors.primary,
                  shimmerProgress: _shimmerController.value,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryContainer),
                    const SizedBox(width: 6),
                    Text(
                      'Cú Mèo đang khởi động bộ não AI... $percent%',
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
          },
        );
    }
  }

  /// Thanh tiến trình sống động (Active Running Progress Bar)
  Widget _buildActiveProgressBar({
    required double value,
    required Color barColor,
    required double shimmerProgress,
  }) {
    return Container(
      width: 270,
      height: 9,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Stack(
          children: [
            // Filled bar with smooth width interpolation
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      barColor.withValues(alpha: 0.85),
                      barColor,
                    ],
                  ),
                ),
              ),
            ),
            // Shimmer gleam sweeping across the bar
            if (value > 0.05)
              Positioned.fill(
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value,
                  child: Transform.translate(
                    offset: Offset((shimmerProgress * 2 - 1) * 140, 0),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.35),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
