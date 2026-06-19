import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Reusable themed AppBar matching the global design system.
PreferredSizeWidget buildDarkAppBar(BuildContext context, String title) =>
    AppBar(
      backgroundColor: context.surface,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: context.accent),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: context.accent.withValues(alpha: 0.25),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: context.onBackground,
          fontWeight: FontWeight.bold,
          fontSize: ScreenSize.height * 0.024,
          letterSpacing: 0.3,
        ),
      ),
    );
