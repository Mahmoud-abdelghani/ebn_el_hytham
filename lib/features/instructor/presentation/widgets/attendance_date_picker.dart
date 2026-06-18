import 'package:ebn_el_hytham/core/utils/color_guid.dart';
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
              ? ColorGuid.amber.withOpacity(0.08)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasDate
                ? ColorGuid.amber.withOpacity(0.5)
                : Colors.white.withOpacity(0.12),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: hasDate
                    ? ColorGuid.amber.withOpacity(0.15)
                    : Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.calendar_month_outlined,
                color: hasDate ? ColorGuid.amber : Colors.white38,
                size: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.03),
            Text(
              hasDate
                  ? DateFormat('EEE, dd MMM yyyy').format(selectedDate!)
                  : 'Select date',
              style: TextStyle(
                color: hasDate ? Colors.white : Colors.white38,
                fontSize: ScreenSize.height * 0.016,
                fontWeight: hasDate ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: hasDate ? ColorGuid.amber.withOpacity(0.7) : Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}