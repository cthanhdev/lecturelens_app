import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import 'skeleton_box.dart';

/// Skeleton Card cho Thư Viện Bài Giảng
class LectureCardSkeleton extends StatelessWidget {
  const LectureCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top badge row skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  SkeletonBox(width: 80, height: 24, borderRadius: 999),
                  SizedBox(width: 8),
                  SkeletonBox(width: 120, height: 24, borderRadius: 999),
                ],
              ),
              const SkeletonBox(width: 28, height: 28, borderRadius: 999),
            ],
          ),
          const SizedBox(height: 14),
          // Title skeleton
          const SkeletonBox(width: double.infinity, height: 20, borderRadius: 6),
          const SizedBox(height: 8),
          const SkeletonBox(width: 200, height: 20, borderRadius: 6),
          const SizedBox(height: 14),
          // Sticky note citation skeleton
          const SkeletonBox(width: double.infinity, height: 56, borderRadius: 16),
          const SizedBox(height: 14),
          // Metrics skeleton
          Row(
            children: const [
              SkeletonBox(width: 70, height: 16, borderRadius: 4),
              SizedBox(width: 12),
              SkeletonBox(width: 60, height: 16, borderRadius: 4),
              SizedBox(width: 12),
              SkeletonBox(width: 80, height: 16, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 14),
          // Button skeleton
          const SkeletonBox(width: double.infinity, height: 40, borderRadius: 999),
        ],
      ),
    );
  }
}
