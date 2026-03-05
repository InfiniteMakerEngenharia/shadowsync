import 'package:flutter/material.dart';

/// Extensão para Color com método seguro de opacidade
extension ColorExtensions on Color {
  /// Substitui withOpacity (depreciado) mantendo a semântica original
  Color withOpacityFixed(double opacity) {
    return withValues(alpha: opacity);
  }
}

class ShadowSyncColors {
  static const Color primaryBackground = Color(0xFF0F172A);
  static const Color secondary = Color(0xFF1E293B);
  static const Color accent = Color(0xFF38BDF8);
  static const Color success = Color(0xFF4ADE80);
  static const Color text = Color(0xFFF8FAFC);
  static const Color overlay = Color(0x401E293B);
  static const Color border = Color(0x66F8FAFC);
}

ThemeData buildShadowSyncTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: ShadowSyncColors.accent,
      secondary: ShadowSyncColors.secondary,
      surface: ShadowSyncColors.secondary,
      onSurface: ShadowSyncColors.text,
      onPrimary: ShadowSyncColors.text,
    ),
  );
}
