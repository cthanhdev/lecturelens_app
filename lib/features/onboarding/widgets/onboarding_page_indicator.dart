import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Dot Page Indicator
class OnboardingPageIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;

  const OnboardingPageIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
