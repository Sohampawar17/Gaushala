import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme.copyWith(
    primary: Colors.yellowAccent,
    surfaceTint: Colors.yellowAccent,
    inversePrimary: Colors.amber, // Lightened version for inverse
  ),
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme.copyWith(
    primary: Colors.yellowAccent,
    surfaceTint: Colors.yellowAccent,
    inversePrimary: Colors.amber,
  ),
  brightness: Brightness.dark,
);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.yellowAccent,
  onPrimary: Colors.black, // Dark text on light yellow
  primaryContainer: Color(0xFFFFF8B0), // Soft yellow container
  onPrimaryContainer: Color(0xFF665500),
  secondary: Color(0xFF6B5E00),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFE59B), // Pale yellow
  onSecondaryContainer: Color(0xFF2F2B00),
  tertiary: Color(0xFFFFE57F),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFFFFF3C1),
  onTertiaryContainer: Color(0xFF3F3700),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFFFDEE), // Light yellow surface
  onSurface: Color(0xFF1C1E21),
  surfaceContainerHighest: Color(0xFFFFF9C4),
  onSurfaceVariant: Color(0xFF3F3F2F),
  outline: Color(0xFF888840),
  onInverseSurface: Color(0xFFFDFCEB),
  inverseSurface: Color(0xFF4D4A00),
  inversePrimary: Color(0xFFFFD740),
  shadow: Color(0xFF000000),
  surfaceTint: Colors.yellowAccent,
  outlineVariant: Color(0xFFD3D388),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.yellowAccent,
  onPrimary: Color(0xFF2C2C00),
  primaryContainer: Color(0xFF665500),
  onPrimaryContainer: Color(0xFFFFFFCC),
  secondary: Color(0xFFE6D200),
  onSecondary: Color(0xFF2E2B00),
  secondaryContainer: Color(0xFF665C00),
  onSecondaryContainer: Color(0xFFFFF5A1),
  tertiary: Color(0xFFFFF176),
  onTertiary: Color(0xFF3F3C00),
  tertiaryContainer: Color(0xFF4F4700),
  onTertiaryContainer: Color(0xFFFFF59D),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF2A2A00),
  onSurface: Color(0xFFF5F5DC),
  surfaceContainerHighest: Color(0xFF444400),
  onSurfaceVariant: Color(0xFFEDE58F),
  outline: Color(0xFFBDB76B),
  onInverseSurface: Color(0xFF2A2A00),
  inverseSurface: Color(0xFFFDFCD8),
  inversePrimary: Color(0xFFFFD740),
  shadow: Color(0xFF000000),
  surfaceTint: Colors.yellowAccent,
  outlineVariant: Color(0xFF99994D),
  scrim: Color(0xFF000000),
);
