import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
    ),
    scaffoldBackgroundColor: AppColors.background,
  );
}