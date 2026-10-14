import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_border_radius.dart';

/// !IMPORTANT: Cấu hình ThemeData toàn diện cho ứng dụng LectureLens
/// CHỈ DẪN: Quản lý cả Light Theme (Bàn học ban ngày) và Dark Theme (Học đêm)
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: Colors.white,
        secondary: AppColors.sakuraPink,
        onSecondary: AppColors.onSakuraPink,
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        surface: AppColors.surfaceCard,
        onSurface: AppColors.onSurface,
        surfaceContainerHighest: AppColors.surfaceContainer,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
      ),
      scaffoldBackgroundColor: AppColors.canvasCream,
      textTheme: AppTypography.createTextTheme(isDark: false),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.onSurface),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        onPrimary: Color(0xFF180065),
        primaryContainer: Color(0xFF4333A4),
        onPrimaryContainer: Colors.white,
        secondary: Color(0xFFFECDDD),
        onSecondary: Color(0xFF7A5562),
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        surface: AppColors.darkSurfaceCard,
        onSurface: AppColors.darkOnSurface,
        surfaceContainerHighest: AppColors.darkSurfaceContainer,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
        outline: AppColors.darkOutline,
      ),
      scaffoldBackgroundColor: AppColors.darkCanvas,
      textTheme: AppTypography.createTextTheme(isDark: true),
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
      ),
    );
  }
}

/// !IMPORTANT: Riverpod Provider quản lý chuyển đổi Theme Mode (Sáng / Tối / Tự động)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.light);

  void setMode(ThemeMode mode) => state = mode;
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});
