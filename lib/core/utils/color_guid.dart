import 'package:flutter/material.dart';

/// ─── UniVerse Brand Palette ───────────────────────────────────────────────
/// Extracted from assets/logo.png — navy base, royal blue primary, gold accent
class AppPalette {
  // ── Brand core ─────────────────────────────────────────────
  static const Color navy = Color(0xFF0B1A2E);
  static const Color navySurface = Color(0xFF132238);
  static const Color navyElevated = Color(0xFF1A2D4A);

  static const Color royalBlue = Color(0xFF2563EB);
  static const Color royalBlueLight = Color(0xFF3B82F6);

  static const Color gold = Color(0xFFF5A623);
  static const Color goldLight = Color(0xFFFFC94A);

  static const Color cyan = Color(0xFF38BDF8);

  // ── Light theme surfaces ───────────────────────────────────
  static const Color lightBackground = Color(0xFFF5F7FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFE8EDF5);

  // ── Text ───────────────────────────────────────────────────
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0BAC8);
  static const Color textMutedDark = Color(0xFF5A6478);

  static const Color textOnLight = Color(0xFF0B1A2E);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // ── Status ─────────────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
}

/// ─── Legacy Design Tokens (dark-theme defaults) ───────────────────────────
/// Existing widgets reference these static values. Dark-theme screens keep
/// working; prefer [Theme.of(context).colorScheme] in new code.
class ColorGuid {
  static const Color scaffoldBackgroundColor = AppPalette.navy;
  static const Color surfaceColor = AppPalette.navySurface;
  static const Color glassFill = Color(0x14FFFFFF);

  static const Color amber = AppPalette.gold;
  static const Color amberSubtle = Color(0x26F5A623);
  static const Color amberBorder = Color(0x80F5A623);

  static const Color royalBlue = AppPalette.royalBlue;
  static const Color royalBlueSubtle = Color(0x262563EB);
  static const Color cyan = AppPalette.cyan;

  static const Color textPrimary = AppPalette.textOnDark;
  static const Color textSecondary = AppPalette.textSecondaryDark;
  static const Color textMuted = AppPalette.textMutedDark;

  static const Color glassBorder = Color(0x2EFFFFFF);
  static const Color boardersColor = Color(0xFF2E3A4A);

  static const Color success = AppPalette.success;
  static const Color error = AppPalette.error;

  @Deprecated('Use ColorGuid.surfaceColor or ColorGuid.amber instead')
  static const Color mainColor = AppPalette.navySurface;
}
