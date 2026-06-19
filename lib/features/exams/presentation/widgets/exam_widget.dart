import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Exam list tile — themed card with accent highlight for next exam.
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
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: next ? context.accent : context.glassBorder,
          width: next ? 1.8 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: next
                ? context.accent.withOpacity(0.15)
                : context.shadowColor,
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
        leading: Text(
          name,
          style: TextStyle(
            color: next ? context.accent : context.onBackground,
            fontWeight: next ? FontWeight.w700 : FontWeight.w500,
            fontSize: ScreenSize.height * 0.017,
          ),
        ),
        dense: true,
        subtitle: Text(
          location,
          style: TextStyle(
            color: context.textMuted,
            fontWeight: FontWeight.w400,
            fontSize: ScreenSize.height * 0.015,
          ),
        ),
        title: Text(
          date,
          style: TextStyle(
            color: context.onSurfaceMuted,
            fontWeight: FontWeight.w400,
            fontSize: ScreenSize.height * 0.017,
          ),
        ),
        trailing: Text(
          chairNum,
          style: TextStyle(
            color: context.accent,
            fontWeight: FontWeight.w600,
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
      ),
    );
  }
}
