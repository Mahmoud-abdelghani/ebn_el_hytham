import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Salary list row — dark [surfaceColor] card with [amber] icon and amount.
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
        // [surfaceColor] card replaces white ListTile
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(12),
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
        // [amber] money icon
        leading: Container(
          width: ScreenSize.height * 0.056,
          height: ScreenSize.height * 0.056,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorGuid.amberSubtle, // amber tinted circle bg
            border: Border.all(color: ColorGuid.amberBorder),
          ),
          child: Icon(
            Icons.monetization_on,
            color: ColorGuid.amber, // [amber] icon
            size: ScreenSize.height * 0.03,
          ),
        ),
        title: Text(
          month,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorGuid.textPrimary, // [textPrimary] white month
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: ColorGuid.textMuted, // [textMuted] grey date
            fontSize: ScreenSize.height * 0.0165,
          ),
        ),
        trailing: Text(
          '\$ $salary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorGuid.amber, // [amber] salary amount
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
      ),
    );
  }
}
