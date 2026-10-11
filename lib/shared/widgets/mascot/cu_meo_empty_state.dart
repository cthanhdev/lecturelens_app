import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../buttons/ll_primary_button.dart';
import '../washi_tape/washi_tape_accent.dart';
import 'cu_meo_widget.dart';

/// !IMPORTANT: Empty State phong cách Cú Mèo ngủ trưa
/// CHỈ DẪN: Hiển thị khi danh sách bài giảng trống hoặc không có kết quả tìm kiếm
class CuMeoEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final CuMeoVariant variant;

  const CuMeoEmptyState({
    super.key,
    this.title = 'Bàn học chưa có bài giảng nào',
    this.subtitle = 'Cú Mèo đang ngủ trưa đợi bạn! Hãy tải lên bản ghi âm bài học đầu tiên để bắt đầu học tập nhẹ nhàng nhé.',
    this.buttonText = 'Tải bản ghi đầu tiên',
    this.onButtonPressed,
    this.variant = CuMeoVariant.sleeping,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(28),
        boxShadow: AppShadows.level1,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Corner washi tape
          const Positioned(
            top: -8,
            left: 20,
            child: WashiTapeAccent(
              color: WashiTapeColor.butterYellow,
              rotationAngle: -0.06,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CuMeoWidget(
                variant: variant,
                size: 130,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
              ),
              if (buttonText != null && onButtonPressed != null) ...[
                const SizedBox(height: 20),
                LlPrimaryButton(
                  text: buttonText!,
                  onPressed: onButtonPressed,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
