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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorGuid.mainColor,
        child: Icon(Icons.edit, color: Colors.white),
      ),
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        title: Text(
          materials[0].name,
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
                      "https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              StudentProfileStringsHelper(
                firstTxt: 'Name: ${materialModel.studentName}',
              ),
              StudentProfileStringsHelper(
                firstTxt: 'ID: ${materialModel.studentId}',
                secondTxt: 'Section: ${materialModel.materialDetails.section}',
              ),

              StudentProfileStringsHelper(
                firstTxt:
                    "Material Code: ${materialModel.materialDetails.code}",
                secondTxt:
                    "Hours: ${materialModel.materialDetails.numberOfHours}",
              ),
              StudentProfileStringsHelper(firstTxt: 'Date of Lectures'),

              StudentProfileStringsHelper(
                firstTxt:
                    "Lecture Date: ${materialModel.materialDetails.lectureDate}",
              ),
              StudentProfileStringsHelper(
                firstTxt:
                    "Location: ${materialModel.materialDetails.lectureLocation}",
              ),
              StudentProfileStringsHelper(firstTxt: 'Degrees details'),
              StudentProfileStringsHelper(
                firstTxt: "mid: ${materialModel.materialDetails.midDegree}",
                secondTxt:
                    "attendance: ${materialModel.materialDetails.attendanceDegree}",
              ),
              StudentProfileStringsHelper(
                firstTxt: "Labs: ${materialModel.materialDetails.labsDegree}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
