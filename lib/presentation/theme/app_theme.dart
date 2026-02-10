import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color orangePrimary = Color(0xFFFF8C42);
  static const Color orangeDark = Color(0xFFE85D04);
  static const Color yellowLight = Color(0xFFFFE66D);
  static const Color yellowClarity = Color(0xFFFFD93D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFBF5);
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color goldSpark = Color(0xFFE8A838);

  static LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [orangePrimary, yellowClarity],
      );

  static LinearGradient get softGlowGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x33FF8C42),
          Color(0x11FFD93D),
        ],
      );

  /// Неоморфная карточка: двойная тень (свет сверху-слева, тень снизу-справа) + мягкое свечение.
  static BoxDecoration cardDecoration({bool withGlow = false}) {
    return BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        // Неоморфизм: верхний светлый край
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.9),
          blurRadius: 20,
          offset: const Offset(-6, -6),
          spreadRadius: -2,
        ),
        // Неоморфизм: нижняя тень
        BoxShadow(
          color: orangeDark.withValues(alpha: 0.15),
          blurRadius: 24,
          offset: const Offset(8, 10),
          spreadRadius: -4,
        ),
        BoxShadow(
          color: orangePrimary.withValues(alpha: 0.12),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
        if (withGlow)
          BoxShadow(
            color: yellowClarity.withValues(alpha: 0.25),
            blurRadius: 28,
            spreadRadius: -6,
          ),
      ],
    );
  }

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: orangePrimary,
          primary: orangePrimary,
          secondary: yellowClarity,
          surface: surfaceLight,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: surfaceLight,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: textPrimary,
          titleTextStyle: TextStyle(
            color: textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: orangePrimary,
            foregroundColor: white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            shadowColor: orangePrimary.withValues(alpha: 0.4),
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: textPrimary),
          headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: textPrimary),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
          bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
          bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
        ),
      );
}
