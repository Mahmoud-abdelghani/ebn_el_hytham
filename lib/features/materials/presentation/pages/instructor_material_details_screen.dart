import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_student_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_data_in_a_row.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_details_tile.dart';
import 'package:ebn_el_hytham/features/military/presentation/widgets/custom_data_container.dart';
import 'package:flutter/material.dart';

class InstructorMaterialDetailsScreen extends StatelessWidget {
  const InstructorMaterialDetailsScreen({super.key});
  static const String routeName = 'InstructorMaterialDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar(materials[0].name),
      body: Column(
        children: [
          // Info row pairs — dark CustomSmallDataContainers
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
            data: 'Students: ${materials[0].totlaNumberOfStrudents}',
            textDirection: TextDirection.ltr,
          ),
          SizedBox(height: ScreenSize.height * 0.01),
          // Student list
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.008),
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
