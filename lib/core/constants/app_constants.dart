/// !IMPORTANT: Hằng số toàn cục cho LectureLens (Tên app, routes, metadata)
class AppConstants {
  AppConstants._();

  static const String appName = 'LectureLens';
  static const String appTagline = 'Biến bài giảng thành kho kiến thức';
  static const String appVersion = '1.0.0 (Beta)';

  // Navigation route paths
  static const String routeSplash = '/';
  static const String routeSplashAi = '/splash-ai';
  static const String routeSplashLoad = '/splash-load';
  static const String routeSplashSlow = '/splash-slow';
  static const String routeSplashError = '/splash-error';
  static const String routeOnboarding = '/onboarding';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeLibrary = '/library';
  static const String routeUpload = '/upload';
  static const String routeProcessing = '/processing';
  static const String routeLectureDetail = '/lecture/:id';
  static const String routeLectureAi = '/lecture/:id/ai';
  static const String routeSearch = '/search';
  static const String routeNotifications = '/notifications';
  static const String routeSettings = '/settings';
}
