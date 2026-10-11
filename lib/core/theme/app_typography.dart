import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// !IMPORTANT: Định nghĩa Typography toàn diện của LectureLens
/// CHỈ DẪN: Quicksand dùng cho tiêu đề tạo cảm giác thân thiện mềm mại;
/// Nunito Sans dùng cho văn bản & nội dung bài giảng để tăng độ đọc rõ ràng,
/// đặc biệt hỗ trợ hoàn hảo tiếng Việt có dấu với line-height >= 1.5.
class AppTypography {
  AppTypography._();

  static TextTheme createTextTheme({bool isDark = false}) {
    final textColor = isDark ? AppColors.darkOnSurface : AppColors.onSurface;
    final variantColor = isDark ? AppColors.darkOnSurfaceVariant : AppColors.onSurfaceVariant;

    return TextTheme(
      // Headlines (Quicksand)
      headlineLarge: GoogleFonts.quicksand(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: textColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.quicksand(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.35,
        color: textColor,
        letterSpacing: -0.3,
      ),
      headlineSmall: GoogleFonts.quicksand(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textColor,
      ),

      // Titles
      titleLarge: GoogleFonts.quicksand(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        height: 1.4,
        color: textColor,
      ),
      titleMedium: GoogleFonts.quicksand(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textColor,
      ),
      titleSmall: GoogleFonts.nunitoSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textColor,
      ),

      // Body Text (Nunito Sans — line-height >= 1.5 cho dấu tiếng Việt)
      bodyLarge: GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textColor,
      ),
      bodySmall: GoogleFonts.nunitoSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: variantColor,
      ),

      // Labels (Nunito Sans)
      labelLarge: GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.4,
        letterSpacing: 0.2,
        color: textColor,
      ),
      labelMedium: GoogleFonts.nunitoSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.2,
        color: textColor,
      ),
      labelSmall: GoogleFonts.nunitoSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: 0.2,
        color: variantColor,
      ),
    );
  }
}
