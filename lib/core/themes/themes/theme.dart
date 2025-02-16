// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_movie_app/core/themes/app_colors.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColors.background,
    onBackground: AppColors.background,
    primary: AppColors.primary,
    onPrimary: AppColors.black,
    secondary: AppColors.secondary,
    onSecondary: Color(0xff6C5070),
    onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
    error: Color.fromARGB(255, 188, 0, 0),
    onError: Color.fromARGB(255, 0, 149, 47),

    onPrimaryContainer: Colors.white,
    outline: Color.fromARGB(255, 194, 180, 196),
    //used in some conditions
    secondaryContainer: Color(0xff6C5070),
    tertiaryContainer: Color(0xFFDDDDDD),
    tertiary: Color(0xFFFFE15D),
    scrim: Color(0xff94B3FD),
  ),
);

// theme dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 14, 14, 14),
    onBackground: Color(0xFFFFFFFF),
    primary: AppColors.primary,
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color.fromARGB(255, 254, 245, 255),
    onSecondary: Color.fromARGB(255, 121, 67, 128),
    surface: Color.fromARGB(255, 164, 146, 167),
    error: Color.fromARGB(255, 188, 0, 0),
    onError: Color.fromARGB(255, 0, 149, 47),
    onSecondaryContainer: Color.fromARGB(255, 14, 14, 14),
    onPrimaryContainer: Colors.white,
    // primaryContainer: Color(0xff01DC82),
    outline: Color.fromARGB(255, 194, 180, 196),
    secondaryContainer: Color(0xFFFFE15D),
    tertiaryContainer: Color(0xff6C5070),
    tertiary: Color(0xFFFFE15D),
    scrim: Color(0xff94B3FD),
  ),
);
