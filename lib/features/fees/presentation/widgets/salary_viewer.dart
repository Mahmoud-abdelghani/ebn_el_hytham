import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

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
    return ListTile(
      leading: Icon(Icons.monetization_on, color: ColorGuid.mainColor, size: ScreenSize.height * 0.04,),
      title: Text(
        month,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
      subtitle: Text(
        date,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          fontSize: ScreenSize.height * 0.0175,
        ),
      ),
      trailing: Text(
        '\$ $salary',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
    );
  }
}
