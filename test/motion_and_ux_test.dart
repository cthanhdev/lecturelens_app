import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/core/motion/app_motion_tokens.dart';
import 'package:lecturelens_app/shared/widgets/interactive/ll_pressable.dart';
import 'package:lecturelens_app/shared/widgets/mascot/cu_meo_widget.dart';
import 'package:lecturelens_app/shared/widgets/audio/audio_progress_bar.dart';
import 'package:lecturelens_app/shared/widgets/dot_background.dart';

void main() {
  group('AppMotionTokens Tests', () {
    test('Token values conform to motion specifications', () {
      expect(AppMotionTokens.micro, const Duration(milliseconds: 120));
      expect(AppMotionTokens.short, const Duration(milliseconds: 220));
      expect(AppMotionTokens.medium, const Duration(milliseconds: 340));
      expect(AppMotionTokens.ambientBreathe, const Duration(milliseconds: 2400));
      expect(AppMotionTokens.pressScaleFactor, 0.965);
    });
  });

  group('LlPressable Widget Tests', () {
    testWidgets('Renders child and triggers onTap callback', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LlPressable(
              onTap: () => tapped = true,
              child: const Text('Press Me'),
            ),
          ),
        ),
      );

      expect(find.text('Press Me'), findsOneWidget);

      await tester.tap(find.text('Press Me'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Scales down when tapped down and returns on tap up', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LlPressable(
              scaleFactor: 0.92,
              onTap: () {},
              child: const SizedBox(width: 100, height: 50, child: Text('Box')),
            ),
          ),
        ),
      );

      final animatedScaleFinder = find.byType(AnimatedScale);
      expect(animatedScaleFinder, findsOneWidget);

      AnimatedScale scaleWidget = tester.widget(animatedScaleFinder);
      expect(scaleWidget.scale, 1.0);

      // Tap down
      final gesture = await tester.startGesture(tester.getCenter(find.text('Box')));
      await tester.pump(const Duration(milliseconds: 50));

      scaleWidget = tester.widget(animatedScaleFinder);
      expect(scaleWidget.scale, 0.92);

      // Release
      await gesture.up();
      await tester.pumpAndSettle();

      scaleWidget = tester.widget(animatedScaleFinder);
      expect(scaleWidget.scale, 1.0);
    });
  });

  group('CuMeoWidget Mascot Tests', () {
    testWidgets('Renders idle variant without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CuMeoWidget(
              variant: CuMeoVariant.idle,
              size: 100,
              isAnimated: false,
            ),
          ),
        ),
      );

      expect(find.byType(CuMeoWidget), findsOneWidget);
    });

    testWidgets('Renders listening variant with animation without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CuMeoWidget(
              variant: CuMeoVariant.listening,
              size: 120,
              isAnimated: true,
            ),
          ),
        ),
      );

      expect(find.byType(CuMeoWidget), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
    });
  });

  group('AudioProgressBar Tests', () {
    testWidgets('Renders progress bar with duration texts', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AudioProgressBar(
              currentPosition: Duration(minutes: 5, seconds: 20),
              totalDuration: Duration(minutes: 45, seconds: 0),
            ),
          ),
        ),
      );

      expect(find.text('05:20'), findsOneWidget);
      expect(find.text('45:00'), findsOneWidget);
    });
  });

  group('DotBackground Tests', () {
    testWidgets('Renders RepaintBoundary and CustomPaint without error', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DotBackground(
              child: Text('Content on Dot Paper'),
            ),
          ),
        ),
      );

      expect(find.text('Content on Dot Paper'), findsOneWidget);
      expect(find.byType(RepaintBoundary), findsWidgets);
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
