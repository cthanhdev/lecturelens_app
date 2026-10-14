import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/core/constants/app_constants.dart';
import 'package:lecturelens_app/core/router/app_router.dart';
import 'package:lecturelens_app/core/router/route_not_found_screen.dart';

void main() {
  group('AppRouter Tests', () {
    testWidgets('Router has configured all expected routes', (tester) async {
      final routes = AppRouter.router.configuration.routes;
      expect(routes, isNotEmpty);
      expect(routes.length, greaterThanOrEqualTo(16));
    });

    testWidgets('RouteNotFoundScreen renders UI and button correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: RouteNotFoundScreen(errorLocation: '/test-404'),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(RouteNotFoundScreen), findsOneWidget);
      expect(find.text('Trang này đã bay mất rồi! 🦉'), findsOneWidget);
      expect(find.text('Về Thư Viện Bài Giảng 📚'), findsOneWidget);
      expect(find.textContaining('/test-404'), findsOneWidget);
    });

    test('Route constants are correctly defined and unique', () {
      final routeList = [
        AppConstants.routeSplash,
        AppConstants.routeSplashAi,
        AppConstants.routeSplashLoad,
        AppConstants.routeSplashSlow,
        AppConstants.routeSplashError,
        AppConstants.routeOnboarding,
        AppConstants.routeLogin,
        AppConstants.routeRegister,
        AppConstants.routeLibrary,
        AppConstants.routeUpload,
        AppConstants.routeProcessing,
        AppConstants.routeLectureDetail,
        AppConstants.routeLectureAi,
        AppConstants.routeSearch,
        AppConstants.routeNotifications,
        AppConstants.routeSettings,
      ];

      expect(routeList.toSet().length, routeList.length, reason: 'All route paths must be unique');
      expect(AppConstants.routeSplash, '/');
      expect(AppConstants.routeSplashAi, '/splash-ai');
      expect(AppConstants.routeSplashLoad, '/splash-load');
      expect(AppConstants.routeSplashSlow, '/splash-slow');
      expect(AppConstants.routeSplashError, '/splash-error');
    });
  });
}
