import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = _buildTheme(Brightness.light);

ThemeData darkTheme = _buildTheme(Brightness.dark);

ThemeData _buildTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  final colorScheme = isDark
      ? const ColorScheme.dark(
          primary: AppPalette.royalBlueLight,
          onPrimary: Colors.white,
          primaryContainer: AppPalette.navyElevated,
          onPrimaryContainer: AppPalette.cyan,
          secondary: AppPalette.gold,
          onSecondary: AppPalette.navy,
          secondaryContainer: Color(0xFF3D2E0A),
          onSecondaryContainer: AppPalette.goldLight,
          tertiary: AppPalette.cyan,
          onTertiary: AppPalette.navy,
          error: AppPalette.error,
          onError: Colors.white,
          surface: AppPalette.navySurface,
          onSurface: AppPalette.textOnDark,
          onSurfaceVariant: AppPalette.textSecondaryDark,
          outline: Color(0xFF2E3A4A),
          outlineVariant: Color(0xFF1E2A3A),
          surfaceContainerHighest: AppPalette.navyElevated,
          surfaceContainerHigh: AppPalette.navySurface,
          surfaceContainer: AppPalette.navySurface,
          surfaceContainerLow: AppPalette.navy,
          surfaceContainerLowest: AppPalette.navy,
        )
      : const ColorScheme.light(
          primary: AppPalette.royalBlue,
          onPrimary: Colors.white,
          primaryContainer: Color(0xFFDBEAFE),
          onPrimaryContainer: AppPalette.navy,
          secondary: AppPalette.gold,
          onSecondary: AppPalette.navy,
          secondaryContainer: Color(0xFFFFF3D6),
          onSecondaryContainer: Color(0xFF5C3D00),
          tertiary: AppPalette.cyan,
          onTertiary: AppPalette.navy,
          error: AppPalette.error,
          onError: Colors.white,
          surface: AppPalette.lightSurface,
          onSurface: AppPalette.textOnLight,
          onSurfaceVariant: AppPalette.textSecondaryLight,
          outline: Color(0xFFCBD5E1),
          outlineVariant: Color(0xFFE2E8F0),
          surfaceContainerHighest: AppPalette.lightSurfaceVariant,
          surfaceContainerHigh: AppPalette.lightSurface,
          surfaceContainer: AppPalette.lightSurface,
          surfaceContainerLow: AppPalette.lightBackground,
          surfaceContainerLowest: AppPalette.lightBackground,
        );

  final accent = colorScheme.secondary;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isDark
        ? AppPalette.navy
        : AppPalette.lightBackground,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      iconTheme: IconThemeData(color: accent),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: isDark ? 0 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark
              ? Colors.white.withValues(alpha: 0.07)
              : colorScheme.outlineVariant,
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: isDark
          ? Colors.white.withValues(alpha: 0.07)
          : colorScheme.outlineVariant,
      thickness: 0.5,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return accent;
        return isDark ? Colors.white38 : Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accent.withValues(alpha: 0.3);
        }
        return isDark ? Colors.white12 : Colors.grey.shade300;
      }),
    ),
    iconTheme: IconThemeData(color: accent),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: colorScheme.onSurface),
      bodyMedium: TextStyle(color: colorScheme.onSurface),
      bodySmall: TextStyle(color: colorScheme.onSurfaceVariant),
      titleLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accent,
      foregroundColor: colorScheme.onSecondary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? AppPalette.navyElevated : colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      hintStyle: TextStyle(
        color: isDark ? AppPalette.textMutedDark : AppPalette.textMutedLight,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: isDark ? AppPalette.navyElevated : AppPalette.navy,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
