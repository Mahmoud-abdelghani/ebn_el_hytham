import 'package:flutter/material.dart';

/// ─── Global Design Token System ───────────────────────────────────────────
/// Design spirit: Dark charcoal base, amber/gold accent, glassmorphism surfaces
/// No blue anywhere — all legacy [mainColor] references now point to [dark]
class ColorGuid {
  // ── Background layers ──────────────────────────────────────
  /// Primary scaffold background — deep charcoal
  static const Color scaffoldBackgroundColor = Color(0xFF161B22);

  /// Slightly lighter surface used for cards, headers, dialogs
  static const Color surfaceColor = Color(0xFF1F2630);

  /// Glass card fill — translucent white overlay on dark surface
  static const Color glassFill = Color(0x14FFFFFF); // white @ 8%

  // ── Accent ────────────────────────────────────────────────
  /// Primary accent — warm amber/gold used for icons, highlights, active states
  static const Color amber = Color(0xFFFFC94A);

  /// Dimmed amber used for icon circle backgrounds
  static const Color amberSubtle = Color(0x26FFC94A); // amber @ 15%

  /// Amber border used on icon rings and pill badges
  static const Color amberBorder = Color(0x80FFC94A); // amber @ 50%

  // ── Text ──────────────────────────────────────────────────
  /// Primary text on dark backgrounds
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary / label text
  static const Color textSecondary = Color(0xFFB0BAC8);

  /// Muted / hint text
  static const Color textMuted = Color(0xFF5A6478);

  // ── Borders ───────────────────────────────────────────────
  /// Glass card border
  static const Color glassBorder = Color(0x2EFFFFFF); // white @ 18%

  /// Input / container borders
  static const Color boardersColor = Color(0xFF2E3A4A);

  // ── Status ────────────────────────────────────────────────
  /// Success green
  static const Color success = Color(0xFF4CAF50);

  /// Error red
  static const Color error = Color(0xFFE53935);

  // ── Legacy alias (do NOT use in new code) ─────────────────
  /// @deprecated  Kept for backward-compat only. Use [surfaceColor] instead.
  // ignore: deprecated_member_use_from_same_package
  @Deprecated('Use ColorGuid.surfaceColor or ColorGuid.amber instead')
  static const Color mainColor = Color(0xFF1F2630);
}
