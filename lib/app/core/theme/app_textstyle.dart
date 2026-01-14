import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/app/core/theme/app_colors.dart';

class AppTextStyles {
  // Private constructor
  AppTextStyles._();

  // Base Style
  static TextStyle get _baseStyle =>
      GoogleFonts.poppins(); // Or TextStyle(fontFamily: 'MyFont')

  // --- Headings ---
  static TextStyle get h1 => _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get h2 => _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // --- Body ---
  static TextStyle get bodyLarge => _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // --- Utility Variations ---
  // Using an extension-like pattern inside the class for variations
  static TextStyle button(Color color) => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color,
  );
}
