import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/splash/splash_ai_startup_screen.dart';
import '../../features/splash/splash_subscreens.dart';
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

/// !IMPORTANT: Định tuyến toàn bộ ứng dụng LectureLens bằng GoRouter
/// CHỈ DẪN: Kết nối 21 màn hình thiết kế. Khi cần thêm route mới hoặc deep link,
/// cấu hình tại danh sách routes bên dưới.
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppConstants.routeSplash,
    routes: [
      // Splash Screens
      GoRoute(
        path: AppConstants.routeSplash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSplashAi,
        builder: (context, state) => const SplashAiStartupScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSplashLoad,
        builder: (context, state) => const SplashLoadingScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSplashSlow,
        builder: (context, state) => const SplashSlowNetworkScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSplashError,
        builder: (context, state) => const SplashErrorScreen(),
      ),

      // Onboarding & Auth
      GoRoute(
        path: AppConstants.routeOnboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppConstants.routeLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.routeRegister,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Library (Home)
      GoRoute(
        path: AppConstants.routeLibrary,
        builder: (context, state) => const LibraryScreen(),
      ),

      // Upload & Processing
      GoRoute(
        path: AppConstants.routeUpload,
        builder: (context, state) => const UploadScreen(),
      ),
      GoRoute(
        path: AppConstants.routeProcessing,
        builder: (context, state) => const ProcessingScreen(),
      ),

      // Lecture Detail & AI Q&A
      GoRoute(
        path: AppConstants.routeLectureDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'lec_1';
          return LectureDetailScreen(lectureId: id);
        },
      ),
      GoRoute(
        path: AppConstants.routeLectureAi,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'lec_1';
          return LectureDetailScreen(lectureId: id);
        },
      ),

      // Search, Notifications & Settings
      GoRoute(
        path: AppConstants.routeSearch,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppConstants.routeNotifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppConstants.routeSettings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
