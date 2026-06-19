import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const AttendanceDatePicker({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDate = selectedDate != null;
    final accent = context.accent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.04,
          vertical: ScreenSize.height * 0.016,
        ),
        decoration: BoxDecoration(
          color: hasDate
              ? accent.withValues(alpha: 0.08)
              : context.glassFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasDate
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
                color: hasDate
                    ? accent.withValues(alpha: 0.15)
                    : context.glassFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.calendar_month_outlined,
                color: hasDate ? accent : context.onSurfaceMuted,
                size: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.03),
            Text(
              hasDate
                  ? DateFormat('EEE, dd MMM yyyy').format(selectedDate!)
                  : 'Select date',
              style: TextStyle(
                color: hasDate ? context.onBackground : context.onSurfaceMuted,
                fontSize: ScreenSize.height * 0.016,
                fontWeight: hasDate ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: hasDate
                  ? accent.withValues(alpha: 0.7)
                  : context.chevronMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
