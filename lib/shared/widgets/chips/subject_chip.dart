import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Subject Chip (Môn học • Trường đại học)
class SubjectChip extends StatelessWidget {
  final String label;
  final String? secondaryLabel;

  const SubjectChip({
    super.key,
    required this.label,
    this.secondaryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
      decoration: BoxDecoration(
        color: AppColors.skyBlue.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.skyBlueDark.withValues(alpha: 0.12),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.skyBlueDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.5,
                  ),
            ),
          ),
          if (secondaryLabel != null && secondaryLabel!.isNotEmpty) ...[
            Text(
              '  •  $secondaryLabel',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
