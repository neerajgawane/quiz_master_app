import 'package:flutter/material.dart';

class QuizAppTheme {
  static const Color primaryColor = Color(0xFF3B5998);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFD1E4FF);
  static const Color textColor = Color(0xFF333333);

  static TextTheme textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: textColor,
      letterSpacing: -0.5,
    ),
    titleLarge: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: textColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: textColor.withOpacity(0.87),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
      ),
      textTheme: textTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}
