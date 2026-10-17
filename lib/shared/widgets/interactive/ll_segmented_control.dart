import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';

class SegmentItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SegmentItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

/// !IMPORTANT: LlSegmentedControl — Thanh Điều Khiển Phân Đoạn Kiểu iOS (iOS Segmented Control)
/// CHỈ DẪN: Thanh chọn (pill indicator) trượt bằng spring physics mượt mà phía dưới mục được chọn.
/// Hỗ trợ cross-fade màu chữ và icon, khoảng chạm 44pt, phản hồi rung nhẹ.
class LlSegmentedControl<T> extends StatelessWidget {
  final List<SegmentItem<T>> items;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;
  final double height;

  const LlSegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onValueChanged,
    this.height = 46.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reduceMotion = AppMotionTokens.shouldReduceMotion(context);

    final selectedIndex = items.indexWhere((item) => item.value == selectedValue);
    final count = items.length;

    return Container(
      height: height,
      padding: const EdgeInsets.all(3.5),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceContainer : const Color(0xFFEFEBF6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.darkOutline : AppColors.outline,
          width: 0.8,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 2) / count;

          return Stack(
            children: [
              // Sliding Spring Pill Indicator
              AnimatedPositioned(
                duration: reduceMotion ? AppMotionTokens.reduceMotionFadeDuration : AppMotionTokens.short,
                curve: AppMotionTokens.appleSpringCurve,
                left: (selectedIndex >= 0 ? selectedIndex : 0) * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.primaryContainer : Colors.white,
                    borderRadius: BorderRadius.circular(10.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Item labels and taps
              Row(
                children: items.map((item) {
                  final isSelected = item.value == selectedValue;

                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (item.value != selectedValue) {
                          HapticFeedback.lightImpact();
                          onValueChanged(item.value);
                        }
                      },
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: AppMotionTokens.short,
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? (isDark ? Colors.white : AppColors.primary)
                                : (isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant),
                            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (item.icon != null) ...[
                                Icon(
                                  item.icon,
                                  size: 16,
                                  color: isSelected
                                      ? (isDark ? Colors.white : AppColors.primary)
                                      : (isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant),
                                ),
                                const SizedBox(width: 5),
                              ],
                              Flexible(
                                child: Text(
                                  item.label,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}
