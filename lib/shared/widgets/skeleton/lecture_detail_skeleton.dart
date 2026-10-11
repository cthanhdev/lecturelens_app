import 'package:flutter/material.dart';
import 'skeleton_box.dart';

/// Skeleton cho trang Chi Tiết Bài Giảng
class LectureDetailSkeleton extends StatelessWidget {
  const LectureDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 16),
          // Audio Player skeleton
          SkeletonBox(width: double.infinity, height: 140, borderRadius: 24),
          SizedBox(height: 20),
          // Tab bar skeleton
          SkeletonBox(width: double.infinity, height: 44, borderRadius: 999),
          SizedBox(height: 20),
          // Content segments skeleton
          SkeletonBox(width: 140, height: 20, borderRadius: 6),
          SizedBox(height: 12),
          SkeletonBox(width: double.infinity, height: 70, borderRadius: 16),
          SizedBox(height: 16),
          SkeletonBox(width: double.infinity, height: 70, borderRadius: 16),
          SizedBox(height: 16),
          SkeletonBox(width: double.infinity, height: 70, borderRadius: 16),
        ],
      ),
    );
  }
}
