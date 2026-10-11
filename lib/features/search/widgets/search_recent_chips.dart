import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Chips tìm kiếm gần đây
class SearchRecentChips extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onSearchSelected;

  const SearchRecentChips({
    super.key,
    required this.recentSearches,
    required this.onSearchSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tìm kiếm gần đây',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: recentSearches.map((term) {
            return GestureDetector(
              onTap: () => onSearchSelected(term),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.history_rounded, size: 14, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      term,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
