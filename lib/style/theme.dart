import 'package:endless_runner/style/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  fontFamily: 'Rubik',
  textTheme: GoogleFonts.rubikTextTheme().copyWith(
    headlineLarge: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 32,
      letterSpacing: 1.6,
    ),
    headlineMedium: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 28,
      letterSpacing: 1.4,
    ),
    headlineSmall: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 24,
      letterSpacing: 1.2,
    ),
    titleLarge: const TextStyle(
      color: Palette.neutralWhite,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      letterSpacing: 1.1,
    ),
    titleMedium: const TextStyle(
      color: Palette.neutralWhite,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      letterSpacing: 0.8,
    ),
    titleSmall: const TextStyle(
      color: Palette.neutralWhite,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: 0.7,
    ),
    labelLarge: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      letterSpacing: 0.7,
    ),
    labelMedium: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      letterSpacing: 0.6,
    ),
    labelSmall: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w600,
      fontSize: 11,
      letterSpacing: 0.55,
    ),
    bodyLarge: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.8,
    ),
    bodyMedium: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.7,
    ),
    bodySmall: const TextStyle(
      color: Palette.neutralBlack,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.6,
    ),
  ),
);
