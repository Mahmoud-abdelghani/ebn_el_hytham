import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

/// Student profile page — dark design restyle.
/// Avatar in amber-bordered rounded rectangle, name in [textPrimary],
/// all metadata via [StudentProfileStringsHelper] with amber values.
class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});
  static const String routeName = 'StudentProfileView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] — deep charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      // Shared dark AppBar
      appBar: buildDarkAppBar('Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.03,
        ),
        child: Column(
          children: [
            // ── Avatar card ───────────────────────────────────────
            Center(
              child: Container(
                width: ScreenSize.width * 0.55,
                height: ScreenSize.height * 0.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.04),
                  // [amber] border ring around avatar
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
            SizedBox(height: ScreenSize.height * 0.02),

            // ── Name ──────────────────────────────────────────────
            Text(
              "Mahmoud Abdelghany",
              style: TextStyle(
                color: ColorGuid.textPrimary, // [textPrimary] white
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.height * 0.03,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.005),
            // ID in [amber]
            Text(
              "ID: 21011276",
              style: TextStyle(
                color: ColorGuid.amber,
                fontWeight: FontWeight.w600,
                fontSize: ScreenSize.height * 0.022,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.004),
            // Department in [textSecondary]
            Text(
              "Communications and Electronics",
              style: TextStyle(
                color: ColorGuid.textSecondary,
                fontWeight: FontWeight.w400,
                fontSize: ScreenSize.height * 0.018,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.004),
            Text(
              "mahmoudabdelghani0997@gmail.com",
              style: TextStyle(
                color: ColorGuid.textMuted, // [textMuted] email
                fontWeight: FontWeight.w300,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),

            // ── Divider ───────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
              child: Divider(color: ColorGuid.boardersColor),
            ),

            // ── Info card ─────────────────────────────────────────
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
                    firstTxt: 'CGPA',
                    secondTxt: '3.33',
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: 'Level',
                    secondTxt: '4',
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: 'Date of birth',
                    secondTxt: '17/02/2003',
                  ),
                  StudentProfileStringsHelper(
                    firstTxt: 'Accepting Date',
                    secondTxt: '22/8/2021',
                  ),
                  StudentProfileStringsHelper(firstTxt: 'Address'),
                  StudentProfileStringsHelper(
                    firstTxt: 'ش الحاج رضوان الهانوفيل العجمى الاسكندرية',
                  ),
                ],
              ),
            ),

            SizedBox(height: ScreenSize.height * 0.02),
            // ── Status badge ──────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                // [success] green badge for no warnings
                color: ColorGuid.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorGuid.success.withOpacity(0.5),
                ),
              ),
              child: Text(
                "✓  لا يوجد اى انذارات اكاديمية",
                style: TextStyle(
                  color: ColorGuid.success, // [success] green
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSize.height * 0.018,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
