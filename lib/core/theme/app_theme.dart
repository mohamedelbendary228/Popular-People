import 'package:flutter/material.dart';
import 'package:popular_people/core/theme/app_colors.dart';
import 'package:popular_people/core/theme/app_text_style.dart';

/// Styles class holding app theming information
class AppThemes {
  /// Dark theme data of the app
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.displayMedium,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.black,
      ).copyWith(surface: AppColors.black),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
    );
  }
}

class TextThemes {
  static TextTheme get textTheme {
    return const TextTheme(
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.body,
      titleMedium: AppTextStyles.bodySmall,
      titleSmall: AppTextStyles.bodyExtraSmall,
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineMedium: AppTextStyles.headlineMedium,
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.white),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.white),
      titleMedium: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
      titleSmall: AppTextStyles.bodyExtraSmall.copyWith(color: AppColors.white),
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.white),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.white),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.white),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.white),
    );
  }

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
      bodyMedium: AppTextStyles.body.copyWith(color: AppColors.primary),
      titleMedium: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
      titleSmall: AppTextStyles.bodyExtraSmall.copyWith(color: AppColors.primary),
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.primary),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.primary),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.primary),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.primary),
    );
  }
}
