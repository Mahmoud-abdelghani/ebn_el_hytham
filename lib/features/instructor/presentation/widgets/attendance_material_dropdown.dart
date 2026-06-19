import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class AttendanceMaterialDropdown extends StatelessWidget {
  final String selectedMaterial;
  final List<String> materials;
  final ValueChanged<String> onSelected;

  const AttendanceMaterialDropdown({
    super.key,
    required this.selectedMaterial,
    required this.materials,
    required this.onSelected,
  });

  static const String _placeholder = 'ShooseMaterial';

  @override
  Widget build(BuildContext context) {
    final bool hasSelection = selectedMaterial != _placeholder;
    final accent = context.accent;

    return GestureDetector(
      onTap: () => _showMaterialMenu(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.04,
          vertical: ScreenSize.height * 0.016,
        ),
        decoration: BoxDecoration(
          color: hasSelection
              ? accent.withValues(alpha: 0.08)
              : context.glassFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasSelection
                ? accent.withValues(alpha: 0.5)
                : context.glassBorder,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: hasSelection
                    ? accent.withValues(alpha: 0.15)
                    : context.glassFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.menu_book_outlined,
                color: hasSelection ? accent : context.onSurfaceMuted,
                size: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.03),
            Expanded(
              child: Text(
                hasSelection ? selectedMaterial : 'Choose material',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: hasSelection
                      ? context.onBackground
                      : context.onSurfaceMuted,
                  fontSize: ScreenSize.height * 0.016,
                  fontWeight:
                      hasSelection ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: hasSelection
                  ? accent.withValues(alpha: 0.7)
                  : context.chevronMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialMenu(BuildContext context) {
    final accent = context.accent;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);

    showMenu<String>(
      context: context,
      color: context.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + box.size.height + 4,
        offset.dx + box.size.width,
        0,
      ),
      items: materials
          .map(
            (m) => PopupMenuItem<String>(
              value: m,
              child: Row(
                children: [
                  Icon(Icons.circle,
                      size: 7,
                      color: accent.withValues(alpha: 0.7)),
                  const SizedBox(width: 10),
                  Text(
                    m,
                    style: TextStyle(
                      color: context.onBackground,
                      fontSize: ScreenSize.height * 0.016,
                    ),
                  ),
                ],
              ),
              onTap: () => onSelected(m),
            ),
          )
          .toList(),
    );
  }
}
