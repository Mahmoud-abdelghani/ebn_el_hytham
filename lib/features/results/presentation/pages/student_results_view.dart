import 'dart:math';

import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/results/data/models/student_result_model.dart';
import 'package:ebn_el_hytham/features/results/presentation/widgets/custom_semester_widget.dart';
import 'package:flutter/material.dart';

class StudentResultsView extends StatefulWidget {
  const StudentResultsView({super.key});
  static const String routeName = 'StudentResultsView';

  @override
  State<StudentResultsView> createState() => _StudentResultsViewState();
}

class _StudentResultsViewState extends State<StudentResultsView> {
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
          "Results",
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
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ListTile(
                    tileColor: Colors.white,
                    minTileHeight: ScreenSize.height * 0.11,
                    leading: Text(
                      "Total GPA: ",
                      style: TextStyle(
                        color: ColorGuid.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenSize.height * 0.0365,
                      ),
                    ),
                    trailing: Text(
                      civilStudentResults.totalGpa,
                      style: TextStyle(
                        color: ColorGuid.mainColor,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenSize.height * 0.0365,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: ScreenSize.height * 0.1),
                ),
                SliverList.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: ScreenSize.height * 0.03),
                  itemBuilder: (context, index) {
                    List<String> readyList = ['Subject', 'Code', 'Grad'];

                    for (var element
                        in civilStudentResults
                            .semestersResults[index]
                            .listMaterialsResults) {
                      readyList.addAll([
                        element.name,
                        element.code,
                        element.grad,
                      ]);
                    }
                    return CustomSemesterWidget(
                      elements: readyList,
                      index: index + 1,
                    );
                  },
                  itemCount: civilStudentResults.semestersResults.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
