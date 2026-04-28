import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvanceTheme {
  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFD7782C),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFF39243),
        onPrimaryContainer: Color(0xFFFFFFFF),
        secondary: Color(0xFF00658C),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFF00BAFD),
        onSecondaryContainer: Color(0xFF004663),
        tertiary: Color(0xFF845300),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFA66900),
        onTertiaryContainer: Color(0xFFFFFFFF),
        error: Color(0xFFBA1A1A),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF93000A),
        surface: Color(0xFFFFF9F5),
        onSurface: Color(0xFF221A15),
        surfaceContainerHighest: Color(0xFFEFE5DE),
        onSurfaceVariant: Color(0xFF4E453F),
        outline: Color(0xFF80756D),
        outlineVariant: Color(0xFFD3C4BB),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFF9F5),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.64,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.24,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.14,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD7782C),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF00658C),
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: Color(0xFF00658C)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD3C4BB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD3C4BB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD7782C), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBA1A1A)),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(color: const Color(0xFF4E453F)),
        floatingLabelStyle: textTheme.bodyMedium?.copyWith(
          color: const Color(0xFFD7782C),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
