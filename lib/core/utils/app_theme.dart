import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:flutter/material.dart';

/// Theme-aware color accessors. Use instead of [ColorGuid] static constants.
extension AppTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get cs => theme.colorScheme;
  bool get isDarkTheme => theme.brightness == Brightness.dark;

  Color get accent => cs.secondary;
  Color get accentSubtle => accent.withValues(alpha: 0.12);
  Color get accentBorder => accent.withValues(alpha: 0.3);
  Color get primaryBrand => cs.primary;

  Color get onBackground => cs.onSurface;
  Color get onSurfaceMuted => cs.onSurfaceVariant;
  Color get surface => cs.surface;
  Color get scaffold => theme.scaffoldBackgroundColor;

  Color get textMuted =>
      isDarkTheme ? AppPalette.textMutedDark : AppPalette.textMutedLight;

  Color get divider =>
      theme.dividerTheme.color ??
      (isDarkTheme
          ? Colors.white.withValues(alpha: 0.07)
          : cs.outlineVariant);

  Color get cardBorder => isDarkTheme
      ? Colors.white.withValues(alpha: 0.07)
      : cs.outlineVariant;

  Color get glassFill => isDarkTheme
      ? const Color(0x14FFFFFF)
      : primaryBrand.withValues(alpha: 0.06);

  Color get glassBorder => isDarkTheme
      ? const Color(0x2EFFFFFF)
      : cs.outline.withValues(alpha: 0.5);

  Color get borderColor => cs.outline;

  Color get chevronMuted =>
      isDarkTheme ? Colors.white24 : cs.onSurfaceVariant.withValues(alpha: 0.4);

  Color get shadowColor =>
      Colors.black.withValues(alpha: isDarkTheme ? 0.15 : 0.06);
}
