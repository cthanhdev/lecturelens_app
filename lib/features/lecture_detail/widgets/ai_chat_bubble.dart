import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/lecture_ui_model.dart';
import '../../../shared/widgets/chips/timestamp_chip.dart';

/// Bubble Chat trong Hỏi Đáp AI Cú Mèo với hoạt ảnh xuất hiện mượt mà
class AiChatBubble extends StatelessWidget {
  final AiChatMessage message;
  final VoidCallback? onCitationTap;

  const AiChatBubble({
    super.key,
    required this.message,
    this.onCitationTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mascot Icon for Owl
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AssetPaths.logoIcon),
            ),
            const SizedBox(width: 8),
          ],

          // Bubble Container with Soft Entrance Animation
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primaryContainer : AppColors.surfaceCard,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(4),
                  bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(20),
                ),
                border: isUser ? null : Border.all(color: AppColors.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isUser ? Colors.white : AppColors.onSurface,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Citation jump if available
                      if (message.citationTime != null) ...[
                        TimestampChip(
                          timestamp: 'Trích dẫn ${message.citationTime}',
                          onTap: onCitationTap,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        message.timestamp,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isUser
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (isUser) const SizedBox(width: 4),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 260.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.1, end: 0, duration: 260.ms, curve: Curves.easeOutCubic)
        .scaleXY(begin: 0.96, end: 1.0, duration: 260.ms, curve: Curves.easeOutCubic);
  }
}
