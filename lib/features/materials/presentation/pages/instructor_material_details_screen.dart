import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_student_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_data_in_a_row.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_details_tile.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_small_data_container.dart';
import 'package:ebn_el_hytham/features/military/presentation/widgets/custom_data_container.dart';
import 'package:flutter/material.dart';

class InstructorMaterialDetailsScreen extends StatelessWidget {
  const InstructorMaterialDetailsScreen({super.key});
  static const String routeName = 'InstructorMaterialDetailsScreen';
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
          materials[0].name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomDataInARow(
            txtLeft: materials[0].department,
            txtRight: materials[0].season,
          ),
          CustomDataInARow(
            txtLeft: materials[0].hall,
            txtRight: materials[0].day,
          ),
          CustomDataContainer(
            data: materials[0].name,
            textDirection: TextDirection.ltr,
          ),
          CustomDataContainer(
            data: 'Students Number: ${materials[0].totlaNumberOfStrudents}',
            textDirection: TextDirection.ltr,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => CustomDetailsTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    InstructorStudentDetailsScreen.routeName,
                    arguments: materials[0].students[index],
                  );
                },
                name: materials[0].students[index].studentName,
                id: materials[0].students[index].studentId,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: ScreenSize.height * 0.01),
              itemCount: materials[0].students.length,
            ),
          ),
        ],
      ),
    );
  }
}
