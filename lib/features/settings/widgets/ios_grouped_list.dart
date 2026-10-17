import 'package:flutter/material.dart';
import '../../../core/motion/app_motion_tokens.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/interactive/ll_pressable.dart';

/// !IMPORTANT: IosGroupedSection — Khối Nhóm Inset Phong Cách Apple Settings
/// CHỈ DẪN: Đóng gói các hàng cài đặt theo dạng Card bo góc 18dp, có tiêu đề mục trên
/// và chú thích dưới, tự động chèn đường kẻ ngăn cách (Divider lùi lề 54pt).
class IosGroupedSection extends StatelessWidget {
  final String? headerTitle;
  final String? footerText;
  final List<Widget> children;
  final EdgeInsetsGeometry margin;

  const IosGroupedSection({
    super.key,
    this.headerTitle,
    this.footerText,
    required this.children,
    this.margin = const EdgeInsets.only(bottom: 24),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerTitle != null)
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 8),
              child: Text(
                headerTitle!.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceCard : AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? AppColors.darkOutline : AppColors.outline,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                children: [
                  for (int i = 0; i < children.length; i++) ...[
                    children[i],
                    if (i < children.length - 1)
                      Divider(
                        height: 1,
                        thickness: 0.8,
                        indent: 54,
                        endIndent: 0,
                        color: isDark ? AppColors.darkOutline : AppColors.outline,
                      ),
                  ],
                ],
              ),
            ),
          ),
          if (footerText != null)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 8),
              child: Text(
                footerText!,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.35,
                  color: isDark
                      ? AppColors.darkOnSurfaceVariant.withValues(alpha: 0.8)
                      : AppColors.onSurfaceVariant.withValues(alpha: 0.8),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// !IMPORTANT: IosGroupedTile — Hàng Cài Đặt Chuẩn Apple HIG
/// CHỈ DẪN: Chiều cao tối thiểu 50pt (>44pt), vi tương tác tactile spring, icon squircle bo tròn
class IosGroupedTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool showChevron;
  final Color? leadingBgColor;

  const IosGroupedTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.value,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.showChevron = false,
    this.leadingBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final content = Container(
      constraints: const BoxConstraints(minHeight: 52),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (leading != null) ...[
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: leadingBgColor ??
                    (isDestructive
                        ? const Color(0xFFFFEBEB)
                        : (isDark ? AppColors.darkSurfaceContainer : AppColors.surfaceContainer)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: leading,
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDestructive
                        ? const Color(0xFFE11D48)
                        : (isDark ? AppColors.darkOnSurface : AppColors.onSurface),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: 8),
            Text(
              value!,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing!,
          ] else if (showChevron) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: (isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant)
                  .withValues(alpha: 0.6),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return LlPressable(
      scaleFactor: AppMotionTokens.pressScale,
      onTap: onTap,
      child: content,
    );
  }
}
