import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/theme/app_colors.dart';

/// Drop Zone chọn tệp âm thanh
class UploadDropZone extends StatelessWidget {
  final String? selectedFileName;
  final String? selectedFileSize;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const UploadDropZone({
    super.key,
    this.selectedFileName,
    this.selectedFileSize,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = selectedFileName != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          color: hasFile ? AppColors.surfaceContainerLow : AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: hasFile ? AppColors.primaryContainer : AppColors.outlineVariant,
            width: 1.8,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              AssetPaths.uploadZone,
              width: 72,
              height: 72,
            ),
            const SizedBox(height: 12),
            Text(
              hasFile ? selectedFileName! : 'Chạm để chọn tệp âm thanh ghi âm',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              hasFile ? (selectedFileSize ?? '') : 'Hỗ trợ MP3, M4A, WAV (tối đa 500MB)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
            ),
            if (hasFile && onClear != null) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onClear,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Đổi tệp khác',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
