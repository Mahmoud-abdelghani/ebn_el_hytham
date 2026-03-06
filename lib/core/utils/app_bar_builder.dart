import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Reusable dark-themed AppBar matching the global design system.
/// [title] — page title
/// [surfaceColor] header, [amber] bottom border, white back arrow
PreferredSizeWidget buildDarkAppBar(String title) => AppBar(
      // [surfaceColor] — dark card appbar replaces old mainColor navy
      backgroundColor: ColorGuid.surfaceColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorGuid.amber), // [amber] back arrow
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          // [amber] hairline separates appbar from page content
          color: ColorGuid.amber.withOpacity(0.25),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ColorGuid.textPrimary, // white title text
          fontWeight: FontWeight.bold,
          fontSize: ScreenSize.height * 0.024,
          letterSpacing: 0.3,
        ),
      ),
    );
