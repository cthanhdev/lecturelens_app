import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

/// Thẻ Thông Tin Ứng Dụng (Version, License, AI Engine)
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Về LectureLens',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Phiên bản', AppConstants.appVersion),
          const Divider(color: AppColors.outline, height: 16),
          _buildInfoRow('Mô hình AI', 'Whisper Large v3 + LLM Citations'),
          const Divider(color: AppColors.outline, height: 16),
          _buildInfoRow('Ngôn ngữ', 'Tiếng Việt (Tối ưu dấu thanh)'),
          const Divider(color: AppColors.outline, height: 16),
          _buildInfoRow('Thiết kế', 'Japanese Pastel Stationery 🌸'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}
