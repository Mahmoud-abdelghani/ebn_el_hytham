import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/fees/data/models/salary_model.dart';
import 'package:ebn_el_hytham/features/fees/presentation/widgets/salary_viewer.dart';
import 'package:flutter/material.dart';

class InstructorSalaryScreen extends StatelessWidget {
  const InstructorSalaryScreen({super.key});
  static const String routeName = 'instructor-salary-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Salary'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.height * 0.012,
        ),
        itemCount: instructorSalaryData.length,
        itemBuilder: (context, index) => SalaryViewer(
          salary: instructorSalaryData[index].amount.toStringAsFixed(1),
          month: instructorSalaryData[index].month,
          date: instructorSalaryData[index].date,
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: ScreenSize.height * 0.008),
      ),
    );
  }
}
