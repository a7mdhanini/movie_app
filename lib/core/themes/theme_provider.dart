import 'package:flutter_movie_app/core/config/base_provider.dart';
import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends BaseProvider {
  bool _isDarkMode = false;
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  bool get isDarkMode => _isDarkMode;

  final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.lightGray,
        secondary: AppColors.secondary,
        onSecondary: AppColors.gray,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.gray2,
        surface: AppColors.white,
        onSurface: AppColors.darkGray,
        primaryContainer: AppColors.background,
        error: AppColors.errorRed,
        onError: AppColors.red,
        tertiaryContainer: AppColors.pink,
        secondaryContainer: AppColors.blue1,
        onSecondaryContainer: AppColors.blue2,
        inverseSurface: AppColors.blue3,
      ));

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
  );

  void toggleTheme() {
    setLoading(true);
    _isDarkMode = !_isDarkMode;
    setLoading(false);
  }
}
