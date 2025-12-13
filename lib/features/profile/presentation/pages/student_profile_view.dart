import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/profile/presentation/widgets/student_profile_strings_helper.dart';
import 'package:flutter/material.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});
  static const String routeName = 'StudentProfileView';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.0486111111121238,
          vertical: ScreenSize.height * 0.0555625000239258,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: ScreenSize.height * 0.005,
            children: [
              Container(
                width: ScreenSize.width * 0.65,
                height: ScreenSize.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.05),
                  color: Colors.white,

                  image: DecorationImage(
                    image: NetworkImage(
                      "https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                "Mahmoud Abdelghany",
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSize.height * 0.035,
                ),
              ),
              Text(
                "ID: 21011276",
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.035,
                ),
              ),
              Text(
                "Communications and Electronics",
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.027,
                ),
              ),
              Text(
                "mahmoudabdelghani0997@gmail.com",
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenSize.height * 0.019,
                ),
              ),
              StudentProfileStringsHelper(
                firstTxt: 'CGPA: 3.33',
                secondTxt: 'level: 4',
              ),
              StudentProfileStringsHelper(
                firstTxt: 'Date of birth: 17/02/2003',
              ),
              StudentProfileStringsHelper(
                firstTxt: 'Accepting Date: 22/8/2021',
              ),
              StudentProfileStringsHelper(firstTxt: 'Address:'),
              StudentProfileStringsHelper(
                firstTxt: 'ش الحاج رضوان الهانوفيل العجمى الاسكندرية',
              ),
              Text(
                "لا يوجد اى انذارات اكاديمية",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenSize.height * 0.03,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
