import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_state_providers.dart';
import '../../../core/theme/app_colors.dart';

/// Header Lời Chào Màn Hình Thư Viện
/// "Xin chào, Minh ✨" • "Bàn học hôm nay đã sẵn sàng rồi nè!"
class LibraryHeader extends ConsumerWidget {
  final String? userName;
  final String? greetingSubtitle;
  final VoidCallback? onAvatarTap;

  const LibraryHeader({
    super.key,
    this.userName,
    this.greetingSubtitle,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final effectiveName = userName ?? (profile.name.split(' ').isNotEmpty ? profile.name.split(' ').last : profile.name);
    final effectiveSubtitle = greetingSubtitle ?? 'Bàn học hôm nay đã sẵn sàng rồi nè!';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'Xin chào, $effectiveName',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                      letterSpacing: -0.3,
                    ),
              ),
            ),
            const SizedBox(width: 6),
            const Text('✨', style: TextStyle(fontSize: 20)),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          effectiveSubtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
