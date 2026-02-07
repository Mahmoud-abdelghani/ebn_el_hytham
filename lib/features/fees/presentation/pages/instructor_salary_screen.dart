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
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: instructorSalaryData.length,
              itemBuilder: (context, index) => SalaryViewer(
                salary: instructorSalaryData[index].amount.toStringAsFixed(1),
                month: instructorSalaryData[index].month,
                date: instructorSalaryData[index].date,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
