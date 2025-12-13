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
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          materialModel.name,
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
            spacing: ScreenSize.height * 0.01,
            children: [
              Container(
                width: ScreenSize.width * 0.65,
                height: ScreenSize.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenSize.height * 0.05),
                  color: Colors.white,

                  image: DecorationImage(
                    image: NetworkImage(
                      'https://cdn.mos.cms.futurecdn.net/MFpjqdSZhjvUZNWyeo52x6-1200-80.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              StudentProfileStringsHelper(
                firstTxt: "Material Code: ${materialModel.code}",
                secondTxt: "Hours: ${materialModel.numberOfHours}",
              ),
              StudentProfileStringsHelper(firstTxt: materialModel.doctorName),
              StudentProfileStringsHelper(firstTxt: "email: "),
              StudentProfileStringsHelper(firstTxt: materialModel.doctorEmail),
              StudentProfileStringsHelper(
                firstTxt: "Lecture Date: ${materialModel.lectureDate}",
              ),
              StudentProfileStringsHelper(firstTxt: "Location:"),
              StudentProfileStringsHelper(
                firstTxt: materialModel.lectureLocation,
              ),
              StudentProfileStringsHelper(
                firstTxt: "Section: ${materialModel.section}",
              ),
              StudentProfileStringsHelper(
                firstTxt: "mid: ${materialModel.midDegree}",
              ),
              StudentProfileStringsHelper(
                firstTxt: "attendance:${materialModel.attendanceDegree}",
              ),
              StudentProfileStringsHelper(
                firstTxt: "Labs: ${materialModel.labsDegree}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
