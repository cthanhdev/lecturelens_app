import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/motion/app_motion_tokens.dart';

enum CuMeoVariant {
  idle,
  listening,
  happy,
  sleeping,
  processing,
}

/// !IMPORTANT: Mascot "Cú Mèo" — Living Study Companion
/// CHỈ DẪN: Hiển thị linh vật Cú Mèo với nhịp thở điều hòa (idle breathing),
/// bay bổng nhẹ nhàng, nghiêng đầu chăm chú khi lắng nghe bài giảng và phản xạ nảy vui vẻ khi chạm vào.
class CuMeoWidget extends StatefulWidget {
  final CuMeoVariant variant;
  final double size;
  final bool isAnimated;
  final String? heroTag;
  final VoidCallback? onTap;

  const CuMeoWidget({
    super.key,
    this.variant = CuMeoVariant.idle,
    this.size = 140.0,
    this.isAnimated = true,
    this.heroTag,
    this.onTap,
  });

  @override
  State<CuMeoWidget> createState() => _CuMeoWidgetState();
}

class _CuMeoWidgetState extends State<CuMeoWidget> with TickerProviderStateMixin {
  late final AnimationController _breatheController;
  late final Animation<double> _breatheAnimation;
  late final Animation<double> _tiltAnimation;

  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Nhịp thở & lơ lửng nhẹ (Idle breathing & float)
    _breatheController = AnimationController(
      vsync: this,
      duration: AppMotionTokens.ambientBreathe,
    );

    _breatheAnimation = Tween<double>(begin: -3.5, end: 3.5).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: AppMotionTokens.sinePulse,
      ),
    );

    // Nghiêng đầu nhẹ khi ở trạng thái lắng nghe hoặc xử lý
    _tiltAnimation = Tween<double>(begin: -0.04, end: 0.04).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: AppMotionTokens.sinePulse,
      ),
    );

    if (widget.isAnimated) {
      _breatheController.repeat(reverse: true);
    }

    // 2. Phản xạ nảy khi người dùng chạm vào (Tap reaction bounce)
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.88).chain(CurveTween(curve: Curves.easeOutQuad)), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 0.88, end: 1.08).chain(CurveTween(curve: Curves.easeOutBack)), weight: 45),
      TweenSequenceItem(tween: Tween<double>(begin: 1.08, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25),
    ]).animate(_bounceController);
  }

  @override
  void didUpdateWidget(covariant CuMeoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimated && !_breatheController.isAnimating) {
      _breatheController.repeat(reverse: true);
    } else if (!widget.isAnimated && _breatheController.isAnimating) {
      _breatheController.stop();
    }
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    _bounceController.forward(from: 0.0);
    widget.onTap?.call();
  }

  String get _assetPath {
    switch (widget.variant) {
      case CuMeoVariant.idle:
        return AssetPaths.logoSplash;
      case CuMeoVariant.listening:
        return AssetPaths.cuMeoListening;
      case CuMeoVariant.happy:
        return AssetPaths.cuMeoHappy;
      case CuMeoVariant.sleeping:
        return AssetPaths.emptyLibrary;
      case CuMeoVariant.processing:
        return AssetPaths.cuMeoListening;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = AppMotionTokens.shouldReduceMotion(context);

    Widget imageContent = SizedBox(
      width: widget.size,
      height: widget.size,
      child: SvgPicture.asset(
        _assetPath,
        fit: BoxFit.contain,
      ),
    );

    if (widget.heroTag != null) {
      imageContent = Hero(
        tag: widget.heroTag!,
        child: imageContent,
      );
    }

    if (reduceMotion || !widget.isAnimated) {
      return GestureDetector(
        onTap: _handleTap,
        child: imageContent,
      );
    }

    final isListeningOrProcessing =
        widget.variant == CuMeoVariant.listening || widget.variant == CuMeoVariant.processing;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: Listenable.merge([_breatheController, _bounceController]),
        builder: (context, child) {
          final floatOffset = _breatheAnimation.value;
          final tiltAngle = isListeningOrProcessing ? _tiltAnimation.value : 0.0;
          final bounceScale = _bounceAnimation.value;

          return Transform.translate(
            offset: Offset(0, floatOffset),
            child: Transform.rotate(
              angle: tiltAngle,
              child: Transform.scale(
                scale: bounceScale,
                child: child,
              ),
            ),
          );
        },
        child: imageContent,
      ),
    );
  }
}
