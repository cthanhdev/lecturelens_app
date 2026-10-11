import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum WashiTapeColor {
  sakuraPink,
  mintGreen,
  butterYellow,
  lavender,
}

/// !IMPORTANT: Dải băng dính Washi Tape trang trí góc thẻ
/// CHỈ DẪN: Tạo hiệu ứng dán băng dính trên sổ tay, có vết xé mờ ở 2 đầu
class WashiTapeAccent extends StatelessWidget {
  final WashiTapeColor color;
  final double width;
  final double height;
  final double rotationAngle; // radians, e.g. -0.05 or 0.05

  const WashiTapeAccent({
    super.key,
    this.color = WashiTapeColor.sakuraPink,
    this.width = 68.0,
    this.height = 14.0,
    this.rotationAngle = -0.04,
  });

  @override
  Widget build(BuildContext context) {
    Color tapeColor;
    switch (color) {
      case WashiTapeColor.sakuraPink:
        tapeColor = AppColors.sakuraPink.withOpacity(0.85);
        break;
      case WashiTapeColor.mintGreen:
        tapeColor = AppColors.mintGreen.withOpacity(0.85);
        break;
      case WashiTapeColor.butterYellow:
        tapeColor = AppColors.butterYellow.withOpacity(0.9);
        break;
      case WashiTapeColor.lavender:
        tapeColor = AppColors.primaryLight.withOpacity(0.9);
        break;
    }

    return Transform.rotate(
      angle: rotationAngle,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: tapeColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
