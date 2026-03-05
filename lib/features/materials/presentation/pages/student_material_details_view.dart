import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/material_model.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

class StudentMaterialDetailsView extends StatelessWidget {
  const StudentMaterialDetailsView({super.key});
  static const String routeName = 'StudentMaterialDetailsView';

  @override
  Widget build(BuildContext context) {
    MaterialModel materialModel =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar(materialModel.name),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.025,
        ),
        child: Column(
          children: [
            // ── Material banner image with amber border ───────────
            Center(
              child: Container(
                width: ScreenSize.width * 0.65,
                height: ScreenSize.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.04),
                  border: Border.all(color: ColorGuid.amber, width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://cdn.mos.cms.futurecdn.net/MFpjqdSZhjvUZNWyeo52x6-1200-80.jpg',
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
            // ── Details card ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenSize.width * 0.045),
              decoration: BoxDecoration(
                // [surfaceColor] dark info card
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
              ),
              child: Column(
                children: [
                  StudentProfileStringsHelper(
                    firstTxt: "Material Code",
                    secondTxt: materialModel.code,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Credit Hours",
                    secondTxt: materialModel.numberOfHours,
                  ),
                  StudentProfileStringsHelper(firstTxt: materialModel.doctorName),
                  StudentProfileStringsHelper(firstTxt: "Email"),
                  StudentProfileStringsHelper(firstTxt: materialModel.doctorEmail),
                  StudentProfileStringsHelper(
                    firstTxt: "Lecture Date",
                    secondTxt: materialModel.lectureDate,
                  ),
                  StudentProfileStringsHelper(firstTxt: "Location"),
                  StudentProfileStringsHelper(firstTxt: materialModel.lectureLocation),
                  StudentProfileStringsHelper(
                    firstTxt: "Section",
                    secondTxt: materialModel.section,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Mid Degree",
                    secondTxt: materialModel.midDegree,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Attendance",
                    secondTxt: materialModel.attendanceDegree,
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: "Labs",
                    secondTxt: materialModel.labsDegree,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
