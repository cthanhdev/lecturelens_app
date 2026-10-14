import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/asset_paths.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/dot_background.dart';

/// !IMPORTANT: Màn hình Splash: AI Khởi Động (SplashAiStartupScreen)
/// CHỈ DẪN: Thanh tiến trình chạy sống động từ 0% lên 88%,
/// Cú Mèo bay bổng mượt mà cùng hiệu ứng xung nhịp AI.
class SplashAiStartupScreen extends StatefulWidget {
  const SplashAiStartupScreen({super.key});

  @override
  State<SplashAiStartupScreen> createState() => _SplashAiStartupScreenState();
}

class _SplashAiStartupScreenState extends State<SplashAiStartupScreen>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  late final AnimationController _progressController;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnimation = CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOutSine,
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );

    _progressController.forward();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: DotBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Smooth floating mascot
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -8 * _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: SvgPicture.asset(
                      AssetPaths.logoSplash,
                      width: 160,
                      height: 190,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Animated Running Progress Bar
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, _) {
                      final targetVal = 0.88 * _progressAnimation.value;
                      final percent = (targetVal * 100).toInt();

                      return Column(
                        children: [
                          Container(
                            width: 250,
                            height: 9,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: targetVal,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.primaryContainer,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 16,
                                color: AppColors.primaryContainer,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Cú Mèo đang khởi động bộ não AI... $percent%',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Chuẩn bị mô hình trích dẫn & giải đáp bài giảng',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
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
