import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

/// Expandable semester fee tile — themed card with accent accents.
class SemesterFeeWidget extends StatelessWidget {
  const SemesterFeeWidget({
    super.key,
    required this.index,
    required this.status,
    required this.totalAmount,
    required this.paid,
    required this.date,
    required this.method,
  });
  final int index;
  final String status;
  final String totalAmount;
  final String paid;
  final String date;
  final String method;

  @override
  Widget build(BuildContext context) {
    final bool isPaid = status != 'Unpaid';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPaid
              ? context.accent.withOpacity(0.4)
              : context.cardBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: context.scaffold.withOpacity(0.6),
        collapsedBackgroundColor: Colors.transparent,
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          'Semester $index',
          style: TextStyle(
            color: context.onBackground,
            fontSize: ScreenSize.height * 0.022,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isPaid
                ? context.accentSubtle
                : context.cs.error.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPaid
                  ? context.accentBorder
                  : context.cs.error.withOpacity(0.5),
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: isPaid ? context.accent : context.cs.error,
              fontSize: ScreenSize.height * 0.015,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.04,
              vertical: ScreenSize.height * 0.01,
            ),
            child: Column(
              children: [
                StudentProfileStringsHelper(
                  firstTxt: 'Total Amount:',
                  secondTxt: totalAmount,
                ),
                StudentProfileStringsHelper(firstTxt: 'Paid:', secondTxt: paid),
                SizedBox(height: ScreenSize.height * 0.01),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Details:',
                    style: TextStyle(
                      color: context.onSurfaceMuted,
                      fontSize: ScreenSize.height * 0.018,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Date:',
                  secondTxt: date.isEmpty ? "Not Paid" : date,
                ),
                StudentProfileStringsHelper(
                  firstTxt: 'Method:',
                  secondTxt: method.isEmpty ? "Not Paid" : method,
                ),
                SizedBox(height: ScreenSize.height * 0.015),
                CustomButton(onTap: () {}, txt: "Download Receipt"),
                SizedBox(height: ScreenSize.height * 0.01),
                if (!isPaid) CustomButton(onTap: () {}, txt: "Pay Pending Fees"),
                SizedBox(height: ScreenSize.height * 0.015),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
