import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_scroll_behavior.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: LectureLensApp(),
    ),
  );
}

/// !IMPORTANT: Điểm Khởi Đầu Của Ứng Dụng (App Entrypoint)
/// CHỈ DẪN: Kết hợp Riverpod cho ThemeModeNotifier và GoRouter cho toàn bộ 21 màn hình
class LectureLensApp extends ConsumerWidget {
  const LectureLensApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      scrollBehavior: const AppScrollBehavior(),
    );
  }
}
