import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Student/material list tile with avatar, name, ID and optional mark.
/// Dark [surfaceColor] card with amber accent on trailing.
class CustomDetailsTile extends StatelessWidget {
  const CustomDetailsTile({
    super.key,
    required this.name,
    required this.id,
    required this.onTap,
    this.mark,
  });
  final String name;
  final String id;
  final VoidCallback onTap;
  final String? mark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.surface,
            border: Border.all(color: context.glassBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: context.shadowColor,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              name,
              style: TextStyle(
                color: context.onBackground,
                fontWeight: FontWeight.w500,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.accentBorder, width: 1.5),
              ),
              child: CircleAvatar(
                radius: ScreenSize.height * 0.03,
                backgroundColor: context.scaffold,
                backgroundImage: const NetworkImage(
                  'https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg',
                ),
              ),
            ),
            subtitle: Text(
              id,
              style: TextStyle(
                color: context.textMuted,
                fontWeight: FontWeight.w300,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),
            trailing: Text(
              mark ?? 'Show',
              style: TextStyle(
                color: context.accent,
                fontWeight: FontWeight.w600,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
