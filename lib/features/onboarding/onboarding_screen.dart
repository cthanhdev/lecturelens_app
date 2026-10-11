import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/app_state_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/buttons/ll_primary_button.dart';
import '../../shared/widgets/dot_background.dart';
import 'onboarding_data.dart';
import 'widgets/onboarding_page_indicator.dart';
import 'widgets/onboarding_slide.dart';

/// !IMPORTANT: Màn hình Onboarding (3 Slides Giới Thiệu)
/// CHỈ DẪN: PageView 3 bước, dot indicator, nút "Bỏ qua" và "Tiếp / Bắt đầu ngay →"
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _completeOnboarding() {
    ref.read(hasCompletedOnboardingProvider.notifier).state = true;
    context.go(AppConstants.routeLogin);
  }

  void _onNext() {
    if (_currentIndex < OnboardingSlideData.slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == OnboardingSlideData.slides.length - 1;

    return Scaffold(
      backgroundColor: AppColors.canvasCream,
      body: DotBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with Skip Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _onSkip,
                      child: Text(
                        'Bỏ qua',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView Slides
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingSlideData.slides.length,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    return OnboardingSlide(data: OnboardingSlideData.slides[index]);
                  },
                ),
              ),

              // Bottom Area: Indicators & Action Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    OnboardingPageIndicator(
                      count: OnboardingSlideData.slides.length,
                      activeIndex: _currentIndex,
                    ),
                    const SizedBox(height: 24),
                    LlPrimaryButton(
                      width: double.infinity,
                      text: isLast ? 'Bắt đầu học ngay 🚀' : 'Tiếp theo →',
                      onPressed: _onNext,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
