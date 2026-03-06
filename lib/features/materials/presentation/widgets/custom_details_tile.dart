import 'package:ebn_el_hytham/core/utils/color_guid.dart';
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
            // [surfaceColor] dark surface card
            color: ColorGuid.surfaceColor,
            // [glassBorder] glass effect border
            border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              name,
              style: TextStyle(
                color: ColorGuid.textPrimary, // [textPrimary] white name
                fontWeight: FontWeight.w500,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // [amber] avatar ring border
                border: Border.all(color: ColorGuid.amberBorder, width: 1.5),
              ),
              child: CircleAvatar(
                radius: ScreenSize.height * 0.03,
                // [scaffoldBackgroundColor] fallback bg
                backgroundColor: ColorGuid.scaffoldBackgroundColor,
                backgroundImage: const NetworkImage(
                  'https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg',
                ),
              ),
            ),
            subtitle: Text(
              id,
              style: TextStyle(
                color: ColorGuid.textMuted, // [textMuted] for subtitle
                fontWeight: FontWeight.w300,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),
            trailing: Text(
              mark ?? 'Show',
              style: TextStyle(
                color: ColorGuid.amber, // [amber] trailing action/mark
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
