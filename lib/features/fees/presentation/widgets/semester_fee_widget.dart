import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

/// Expandable semester fee tile — dark [surfaceColor] card with amber accents.
/// Expansion reveals payment details and action buttons.
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
        // [surfaceColor] card replaces white
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // [amber] border when paid, [boardersColor] when unpaid
          color: isPaid
              ? ColorGuid.amber.withOpacity(0.4)
              : ColorGuid.boardersColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        // [scaffoldBackgroundColor] expanded bg
        backgroundColor: ColorGuid.scaffoldBackgroundColor.withOpacity(0.6),
        collapsedBackgroundColor: Colors.transparent,
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          'Semester $index',
          style: TextStyle(
            color: ColorGuid.textPrimary, // [textPrimary] white
            fontSize: ScreenSize.height * 0.022,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            // [amber] pill for paid, [error] for unpaid status
            color: isPaid
                ? ColorGuid.amber.withOpacity(0.15)
                : ColorGuid.error.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPaid
                  ? ColorGuid.amber.withOpacity(0.5)
                  : ColorGuid.error.withOpacity(0.5),
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: isPaid ? ColorGuid.amber : ColorGuid.error,
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
                // Section label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Details:',
                    style: TextStyle(
                      color: ColorGuid.textSecondary,
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
