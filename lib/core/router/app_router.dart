import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../../features/splash/splash.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/login/login_screen.dart';
import '../../features/auth/register/register_screen.dart';
import '../../features/library/library_screen.dart';
import '../../features/upload/upload_screen.dart';
import '../../features/processing/processing_screen.dart';
import '../../features/lecture_detail/lecture_detail_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/settings/settings_screen.dart';

import 'route_not_found_screen.dart';
import '../../shared/models/lecture_ui_model.dart';

/// !IMPORTANT: Định tuyến toàn bộ ứng dụng LectureLens bằng GoRouter
/// CHỈ DẪN: Kết nối các màn hình thiết kế, có xử lý errorBuilder (404), deep linking
/// và hiệu ứng chuyển trang mượt mà (smooth page transitions).
class AppRouter {
  AppRouter._();

  static Page<dynamic> _buildFadePage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final inCurved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final outCurved = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeInCubic,
          reverseCurve: Curves.easeOutCubic,
        );

        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(outCurved),
            child: FadeTransition(
              opacity: inCurved,
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// !IMPORTANT: Chuyển cảnh Shared-Surface mượt mà dành riêng cho các màn hình Auth (Login <-> Register)
  /// Tránh tình trạng hai form đè chồng mờ lên nhau gây giật hay bóng mờ chữ (double-exposure).
  static Page<dynamic> _buildAuthPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Màn hình cũ: thu nhỏ nhẹ và mờ dần nhanh chóng trong 40% đầu
        final outCurved = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeInCubic,
          reverseCurve: Curves.easeOutCubic,
        );
        final outFade = Tween<double>(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: secondaryAnimation,
            curve: const Interval(0.0, 0.42, curve: Curves.easeIn),
          ),
        );
        final outScale = Tween<double>(begin: 1.0, end: 0.965).animate(outCurved);

        // Màn hình mới: phóng to nhẹ từ 0.965 lên 1.0 và hiện dần từ 22%
        final inCurved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final inFade = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.22, 1.0, curve: Curves.easeOutCubic),
          ),
        );
        final inScale = Tween<double>(begin: 0.965, end: 1.0).animate(inCurved);

        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: FadeTransition(
            opacity: outFade,
            child: ScaleTransition(
              scale: outScale,
              child: FadeTransition(
                opacity: inFade,
                child: ScaleTransition(
                  scale: inScale,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Page<dynamic> _buildSlidePage({
    required LocalKey key,
    required Widget child,
    Offset beginOffset = const Offset(0.04, 0),
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedIn = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final curvedOut = CurvedAnimation(
          parent: secondaryAnimation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        // Trang đang vào
        final primarySlide = Tween<Offset>(
          begin: beginOffset,
          end: Offset.zero,
        ).animate(curvedIn);

        final primaryFade = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.12, 1.0, curve: Curves.easeOutCubic),
            reverseCurve: const Interval(0.0, 0.88, curve: Curves.easeInCubic),
          ),
        );

        final primaryScale = Tween<double>(
          begin: 0.985,
          end: 1.0,
        ).animate(curvedIn);

        // Trang bị đẩy về sau (thoát nhẹ để không bị chồng lớp đè)
        final secondarySlide = Tween<Offset>(
          begin: Offset.zero,
          end: Offset(-beginOffset.dx * 0.5, -beginOffset.dy * 0.5),
        ).animate(curvedOut);

        final secondaryFade = Tween<double>(
          begin: 1.0,
          end: 0.7,
        ).animate(curvedOut);

        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SlideTransition(
            position: secondarySlide,
            child: FadeTransition(
              opacity: secondaryFade,
              child: SlideTransition(
                position: primarySlide,
                child: FadeTransition(
                  opacity: primaryFade,
                  child: ScaleTransition(
                    scale: primaryScale,
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.routeSplash,
    errorBuilder: (context, state) => RouteNotFoundScreen(
      errorLocation: state.uri.toString(),
    ),
    routes: [
      // Splash Screens
      GoRoute(
        path: AppConstants.routeSplash,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeSplashAi,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const SplashAiStartupScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeSplashLoad,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const SplashLoadingScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeSplashSlow,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const SplashSlowNetworkScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeSplashError,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const SplashErrorScreen(),
        ),
      ),

      // Onboarding & Auth
      GoRoute(
        path: AppConstants.routeOnboarding,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeLogin,
        pageBuilder: (context, state) => _buildAuthPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeRegister,
        pageBuilder: (context, state) => _buildAuthPage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),

      // Library (Home)
      GoRoute(
        path: AppConstants.routeLibrary,
        pageBuilder: (context, state) => _buildFadePage(
          key: state.pageKey,
          child: const LibraryScreen(),
        ),
      ),

      // Upload & Processing
      GoRoute(
        path: AppConstants.routeUpload,
        pageBuilder: (context, state) => _buildSlidePage(
          key: state.pageKey,
          beginOffset: const Offset(0, 0.06),
          child: const UploadScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeProcessing,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _buildSlidePage(
            key: state.pageKey,
            beginOffset: const Offset(0, 0.06),
            child: ProcessingScreen(
              lectureTitle: extra?['title'] as String?,
              lectureSubject: extra?['subject'] as String?,
            ),
          );
        },
      ),

      // Lecture Detail & AI Q&A
      GoRoute(
        path: AppConstants.routeLectureDetail,
        pageBuilder: (context, state) {
          final defaultId = LectureUiModel.mockLectures.isNotEmpty
              ? LectureUiModel.mockLectures.first.id
              : 'lec_1';
          final id = state.pathParameters['id'] ?? defaultId;
          final extra = state.extra as Map<String, dynamic>?;
          final tabIndex = extra?['initialTabIndex'] as int? ??
              int.tryParse(state.uri.queryParameters['tab'] ?? '') ??
              0;
          return _buildSlidePage(
            key: state.pageKey,
            beginOffset: const Offset(0.04, 0),
            child: LectureDetailScreen(
              lectureId: id,
              initialTabIndex: tabIndex,
              highlightSeconds: extra?['highlightSeconds'] as int?,
              highlightText: extra?['highlightText'] as String?,
            ),
          );
        },
      ),
      GoRoute(
        path: AppConstants.routeLectureAi,
        pageBuilder: (context, state) {
          final defaultId = LectureUiModel.mockLectures.isNotEmpty
              ? LectureUiModel.mockLectures.first.id
              : 'lec_1';
          final id = state.pathParameters['id'] ?? defaultId;
          return _buildSlidePage(
            key: state.pageKey,
            beginOffset: const Offset(0.04, 0),
            child: LectureDetailScreen(
              lectureId: id,
              initialTabIndex: 1, // Kích hoạt ngay tab Hỏi đáp AI ✨
            ),
          );
        },
      ),

      // Search, Notifications & Settings
      GoRoute(
        path: AppConstants.routeSearch,
        pageBuilder: (context, state) => _buildSlidePage(
          key: state.pageKey,
          beginOffset: const Offset(0, 0.04),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeNotifications,
        pageBuilder: (context, state) => _buildSlidePage(
          key: state.pageKey,
          beginOffset: const Offset(0.04, 0),
          child: const NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: AppConstants.routeSettings,
        pageBuilder: (context, state) => _buildSlidePage(
          key: state.pageKey,
          beginOffset: const Offset(0.04, 0),
          child: const SettingsScreen(),
        ),
      ),
    ],
  );
}
