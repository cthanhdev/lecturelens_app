import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Banner Mẹo Tìm Kiếm từ Cú Mèo 💡
class SearchCuMeoTip extends StatelessWidget {
  const SearchCuMeoTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6D9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFECC0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mẹo tìm kiếm thông minh từ Cú Mèo',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.butterYellowDark,
                        fontSize: 12,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Bạn có thể tìm kiếm theo từ khóa lý thuyết, tên công thức, hoặc mốc thời gian giảng dạy.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.butterYellowDark.withOpacity(0.9),
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
