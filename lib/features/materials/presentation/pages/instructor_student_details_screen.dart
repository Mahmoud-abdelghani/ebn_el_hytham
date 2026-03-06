import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/data/models/student_material_model.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

class InstructorStudentDetailsScreen extends StatelessWidget {
  const InstructorStudentDetailsScreen({super.key});
  static const String routeName = 'InstructorStudentDetailsScreen';

  @override
  Widget build(BuildContext context) {
    StudentMaterialModel materialModel =
        ModalRoute.of(context)!.settings.arguments as StudentMaterialModel;
    return Scaffold(
      // [amber] FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorGuid.amber, // [amber] FAB replaces old mainColor
        child: const Icon(Icons.edit, color: Color(0xFF161B22)),
      ),
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar(materials[0].name),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.025,
        ),
        child: Column(
          children: [
            // ── Avatar with amber border ──────────────────────────
            Center(
              child: Container(
                width: ScreenSize.width * 0.55,
                height: ScreenSize.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.04),
                  border: Border.all(color: ColorGuid.amber, width: 2.5),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
              child: Divider(color: ColorGuid.boardersColor),
            ),
            // ── Student details card [surfaceColor] ───────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenSize.width * 0.045),
              decoration: BoxDecoration(
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
              ),
              child: Column(
                children: [
                  StudentProfileStringsHelper(
                    firstTxt: 'Name',
                    secondTxt: materialModel.studentName,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: 'ID',
                    secondTxt: materialModel.studentId,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: 'Section',
                    secondTxt: materialModel.materialDetails.section,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Material Code",
                    secondTxt: materialModel.materialDetails.code,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Hours",
                    secondTxt: materialModel.materialDetails.numberOfHours,
                  ),
                  StudentProfileStringsHelper(firstTxt: 'Date of Lectures'),
                  StudentProfileStringsHelper(
                    firstTxt: "Lecture Date",
                    secondTxt: materialModel.materialDetails.lectureDate,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Location",
                    secondTxt: materialModel.materialDetails.lectureLocation,
                  ),
                  StudentProfileStringsHelper(firstTxt: 'Degree Details'),
                  StudentProfileStringsHelper(
                    firstTxt: "Mid",
                    secondTxt: materialModel.materialDetails.midDegree,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Attendance",
                    secondTxt: materialModel.materialDetails.attendanceDegree,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Labs",
                    secondTxt: materialModel.materialDetails.labsDegree,
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.08),
          ],
        ),
      ),
    );
  }
}
