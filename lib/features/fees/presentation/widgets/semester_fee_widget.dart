import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/widgets/custom_button.dart';
import 'package:ebn_el_hytham/features/fees/data/models/student_fees_model.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

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
    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      title: Text(
        'Semester $index',
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.03,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        status,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.03,
          fontWeight: FontWeight.w400,
        ),
      ),
      children: [
        Column(
          children: [
            
            StudentProfileStringsHelper(
              firstTxt: 'Total Amount:',
              secondTxt: totalAmount,
            ),
            StudentProfileStringsHelper(firstTxt: 'Paid:', secondTxt: paid),
            SizedBox(height: ScreenSize.height * 0.02),
            Text(
              'Payment Details:',
              style: TextStyle(
                color: ColorGuid.mainColor,
                fontSize: ScreenSize.height * 0.03,
                fontWeight: FontWeight.w400,
              ),
            ),
            StudentProfileStringsHelper(
              firstTxt: 'Date:',
              secondTxt: date.isEmpty ? "Not Paid" : date,
            ),
            StudentProfileStringsHelper(
              firstTxt: 'Method :',
              secondTxt: method.isEmpty ? "Not Paid" : method,
            ),
            SizedBox(height: ScreenSize.height * 0.015),
            CustomButton(onTap: () {}, txt: "Download Receipt"),
            SizedBox(height: ScreenSize.height * 0.015),
            status == 'Unpaid'
                ? CustomButton(onTap: () {}, txt: "Pay Pending Fees")
                : SizedBox(),
            SizedBox(height: ScreenSize.height * 0.015),
          ],
        ),
      ],
    );
  }
}
