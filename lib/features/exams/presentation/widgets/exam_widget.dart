import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Exam list tile — dark [surfaceColor] card with [amber] highlight for next exam.
class ExamWidget extends StatelessWidget {
  const ExamWidget({
    super.key,
    required this.name,
    required this.date,
    required this.location,
    required this.chairNum,
    required this.next,
  });
  final String name;
  final String date;
  final String location;
  final String chairNum;
  final bool next;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        // [surfaceColor] dark card base
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // [amber] border highlights the next exam, [glassBorder] for others
          color: next ? ColorGuid.amber : ColorGuid.glassBorder,
          width: next ? 1.8 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: next
                ? ColorGuid.amber.withOpacity(0.15) // amber glow for next
                : Colors.black.withOpacity(0.2),
            blurRadius: next ? 12 : 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.04,
          vertical: ScreenSize.height * 0.008,
        ),
        // Subject name — [textPrimary] or [amber] if next
        leading: Text(
          name,
          style: TextStyle(
            color: next ? ColorGuid.amber : ColorGuid.textPrimary,
            fontWeight: next ? FontWeight.w700 : FontWeight.w500,
            fontSize: ScreenSize.height * 0.017,
          ),
        ),
        dense: true,
        // Location in [textMuted]
        subtitle: Text(
          location,
          style: TextStyle(
            color: ColorGuid.textMuted,
            fontWeight: FontWeight.w400,
            fontSize: ScreenSize.height * 0.015,
          ),
        ),
        // Date in [textSecondary]
        title: Text(
          date,
          style: TextStyle(
            color: ColorGuid.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: ScreenSize.height * 0.017,
          ),
        ),
        // Chair number in [amber]
        trailing: Text(
          chairNum,
          style: TextStyle(
            color: ColorGuid.amber,
            fontWeight: FontWeight.w600,
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
      ),
    );
  }
}
