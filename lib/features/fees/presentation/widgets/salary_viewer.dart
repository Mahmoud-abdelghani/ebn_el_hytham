import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Salary list row — themed card with accent icon and amount.
class SalaryViewer extends StatelessWidget {
  const SalaryViewer({
    super.key,
    required this.salary,
    required this.month,
    required this.date,
  });
  final String salary;
  final String month;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
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
        leading: Container(
          width: ScreenSize.height * 0.056,
          height: ScreenSize.height * 0.056,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.accentSubtle,
            border: Border.all(color: context.accentBorder),
          ),
          child: Icon(
            Icons.monetization_on,
            color: context.accent,
            size: ScreenSize.height * 0.03,
          ),
        ),
        title: Text(
          month,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.onBackground,
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: context.textMuted,
            fontSize: ScreenSize.height * 0.0165,
          ),
        ),
        trailing: Text(
          '\$ $salary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.accent,
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
      ),
    );
  }
}
