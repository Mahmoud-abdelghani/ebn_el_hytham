import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/exams/data/models/exam_table.dart';
import 'package:ebn_el_hytham/features/exams/presentation/widgets/exam_widget.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:flutter/material.dart';

class StudentExamsTable extends StatefulWidget {
  const StudentExamsTable({super.key});
  static const String routeName = "StudentExamsTable";

  @override
  State<StudentExamsTable> createState() => _StudentExamsTableState();
}

class _StudentExamsTableState extends State<StudentExamsTable> {
  String nextName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          'Exams Table',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: ScreenSize.height * 0.135,
              child: Padding(
                padding: EdgeInsets.only(right: ScreenSize.width * 0.67),
                child: FeatureContainer(
                  iconPath: 'assets/Time table.png',
                  title: "Next Exam",
                  onTap: () {
                    nextName = civilExamTable.nextExamName;
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
          SliverList.separated(
            itemBuilder: (context, index) => ExamWidget(
              next: nextName == civilExamTable.exams[index].name,
              name: civilExamTable.exams[index].name,
              date: civilExamTable.exams[index].date,
              location: civilExamTable.exams[index].location,
              chairNum: civilExamTable.exams[index].chairNum,
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.01),
            itemCount: civilExamTable.exams.length,
          ),
        ],
      ),
    );
  }
}
