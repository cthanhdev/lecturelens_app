import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';

enum CuMeoVariant {
  idle,
  listening,
  happy,
  sleeping,
  processing,
}

/// !IMPORTANT: Mascot "Cú Mèo" — Study Companion
/// CHỈ DẪN: Hiển thị linh vật Cú Mèo đáng yêu theo từng biểu cảm (Lắng nghe, Ngủ trưa, Vui vẻ,...)
class CuMeoWidget extends StatelessWidget {
  final CuMeoVariant variant;
  final double size;

  const CuMeoWidget({
    super.key,
    this.variant = CuMeoVariant.idle,
    this.size = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    String assetPath;
    switch (variant) {
      case CuMeoVariant.idle:
        assetPath = AssetPaths.logoSplash;
        break;
      case CuMeoVariant.listening:
        assetPath = AssetPaths.cuMeoListening;
        break;
      case CuMeoVariant.happy:
        assetPath = AssetPaths.cuMeoHappy;
        break;
      case CuMeoVariant.sleeping:
        assetPath = AssetPaths.emptyLibrary;
        break;
      case CuMeoVariant.processing:
        assetPath = AssetPaths.cuMeoListening;
        break;
    }

    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
