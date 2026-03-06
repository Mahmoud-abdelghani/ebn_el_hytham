import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Dark-themed elevated button — [amber] for confirm, [surfaceColor] for cancel.
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
    // Determine whether this is the primary (amber) or secondary (cancel) button
    final bool isPrimary = color == ColorGuid.amber;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        // [amber] for primary, [surfaceColor] for cancel
        backgroundColor: isPrimary ? ColorGuid.amber : ColorGuid.surfaceColor,
        foregroundColor: isPrimary ? const Color(0xFF161B22) : ColorGuid.textSecondary,
        side: isPrimary
            ? null
            : BorderSide(color: ColorGuid.boardersColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: isPrimary ? const Color(0xFF161B22) : ColorGuid.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: ScreenSize.height * 0.022,
        ),
      ),
    );
  }
}
