import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Theme-aware elevated button — [accent] for confirm, [surface] for cancel.
class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.txt,
    required this.color,
    required this.onTap,
  });
  final String txt;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = context.accent;
    final bool isPrimary = color == accent;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? accent : context.surface,
        foregroundColor:
            isPrimary ? const Color(0xFF161B22) : context.onSurfaceMuted,
        side: isPrimary ? null : BorderSide(color: context.borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: isPrimary ? const Color(0xFF161B22) : context.onSurfaceMuted,
          fontWeight: FontWeight.w600,
          fontSize: ScreenSize.height * 0.022,
        ),
      ),
    );
  }
}
