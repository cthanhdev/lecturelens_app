import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Bộ chọn Giao diện (Sáng / Tối / Tự động)
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

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
          Row(
            children: [
              const Icon(Icons.palette_outlined, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Giao diện ứng dụng',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildThemeOption(
                context,
                title: 'Bàn học (Sáng)',
                mode: ThemeMode.light,
                currentMode: currentMode,
                icon: Icons.light_mode_rounded,
                onTap: () => ref.read(themeModeProvider.notifier).setMode(ThemeMode.light),
              ),
              const SizedBox(width: 8),
              _buildThemeOption(
                context,
                title: 'Học đêm (Tối)',
                mode: ThemeMode.dark,
                currentMode: currentMode,
                icon: Icons.dark_mode_rounded,
                onTap: () => ref.read(themeModeProvider.notifier).setMode(ThemeMode.dark),
              ),
              const SizedBox(width: 8),
              _buildThemeOption(
                context,
                title: 'Hệ thống',
                mode: ThemeMode.system,
                currentMode: currentMode,
                icon: Icons.settings_brightness_rounded,
                onTap: () => ref.read(themeModeProvider.notifier).setMode(ThemeMode.system),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required ThemeMode mode,
    required ThemeMode currentMode,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isSelected = currentMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primaryContainer : AppColors.outline,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
