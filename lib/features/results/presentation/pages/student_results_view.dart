import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
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
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Results'),
      body: CustomScrollView(
        slivers: [
          // ── Total GPA banner ─────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
                vertical: ScreenSize.height * 0.015,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.05,
                vertical: ScreenSize.height * 0.022,
              ),
              decoration: BoxDecoration(
                // [surfaceColor] GPA banner card
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorGuid.amber.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: ColorGuid.amber.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total GPA:",
                    style: TextStyle(
                      color: ColorGuid.textSecondary, // [textSecondary] label
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenSize.height * 0.025,
                    ),
                  ),
                  // [amber] GPA value
                  Text(
                    civilStudentResults.totalGpa,
                    style: TextStyle(
                      color: ColorGuid.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenSize.height * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.01)),
          // ── Semester results list ────────────────────────────────
          SliverList.separated(
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.012),
            itemBuilder: (context, index) {
              List<String> readyList = ['Subject', 'Code', 'Grade'];
              for (var element in civilStudentResults
                  .semestersResults[index]
                  .listMaterialsResults) {
                readyList.addAll([element.name, element.code, element.grad]);
              }
              return CustomSemesterWidget(elements: readyList, index: index + 1);
            },
            itemCount: civilStudentResults.semestersResults.length,
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
        ],
      ),
    );
  }
}
