import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.warmWhite,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.warmWhite,
        ),
        fontFamily: 'serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.warmWhite,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.darkOlive),
        ),
      );
}