import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/interactive/ll_pressable.dart';

enum LibraryFilter {
  all,
  ready,
  processing,
  tech,
}

/// Filter Chips ngang cho Thư Viện Bài Giảng với vi phản hồi xúc giác
class LibraryFilterTabs extends StatelessWidget {
  final LibraryFilter currentFilter;
  final ValueChanged<LibraryFilter> onFilterChanged;
  final int totalCount;

  const LibraryFilterTabs({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
    this.totalCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(
            context,
            filter: LibraryFilter.all,
            label: 'Tất cả ($totalCount)',
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            filter: LibraryFilter.ready,
            label: 'Sẵn sàng',
            dotColor: AppColors.mintGreenDark,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            filter: LibraryFilter.processing,
            label: 'Đang xử lý',
            dotColor: AppColors.warning,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            filter: LibraryFilter.tech,
            label: 'Công nghệ',
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required LibraryFilter filter,
    required String label,
    Color? dotColor,
  }) {
    final isSelected = currentFilter == filter;

    return LlPressable(
      scaleFactor: 0.93,
      onTap: () => onFilterChanged(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(999),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null && !isSelected) ...[
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
