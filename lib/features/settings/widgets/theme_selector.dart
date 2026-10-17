import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/interactive/ll_segmented_control.dart';

/// !IMPORTANT: ThemeSelector — Bộ Chọn Giao Diện Apple Segmented Control
/// CHỈ DẪN: Thanh chọn trượt spring giữa Bàn học (Sáng) / Học đêm (Tối) / Hệ thống,
/// theme đổi ngay lập tức với hiệu ứng cross-fade mượt mà.
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LlSegmentedControl<ThemeMode>(
          selectedValue: currentMode,
          onValueChanged: (mode) {
            ref.read(themeModeProvider.notifier).setMode(mode);
          },
          items: const [
            SegmentItem<ThemeMode>(
              value: ThemeMode.light,
              label: 'Sáng',
              icon: Icons.wb_sunny_rounded,
            ),
            SegmentItem<ThemeMode>(
              value: ThemeMode.dark,
              label: 'Tối',
              icon: Icons.nightlight_round,
            ),
            SegmentItem<ThemeMode>(
              value: ThemeMode.system,
              label: 'Hệ thống',
              icon: Icons.settings_brightness_rounded,
            ),
          ],
        ),
      ],
    );
  }
}
