import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Header Lời Chào Màn Hình Thư Viện
/// "Xin chào, Minh ✨" • "Bàn học hôm nay đã sẵn sàng rồi nè!"
class LibraryHeader extends StatelessWidget {
  final String userName;
  final String greetingSubtitle;
  final VoidCallback? onAvatarTap;

  const LibraryHeader({
    super.key,
    this.userName = 'Minh',
    this.greetingSubtitle = 'Bàn học hôm nay đã sẵn sàng rồi nè!',
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Xin chào, $userName',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                          letterSpacing: -0.3,
                        ),
                  ),
                  const SizedBox(width: 6),
                  const Text('✨', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                greetingSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
        // Avatar with Online Badge
        GestureDetector(
          onTap: onAvatarTap,
          child: Stack(
            children: [
              Container(
                width: 46,
                height: 46,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerHigh,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryContainer.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981), // active green
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.surfaceCard,
                      width: 2.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
