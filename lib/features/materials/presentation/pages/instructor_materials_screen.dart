import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/data/models/material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_material_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_material_container.dart';
import 'package:flutter/material.dart';

class InstructorMaterialsScreen extends StatelessWidget {
  const InstructorMaterialsScreen({super.key});
  static const String routeName = 'InstructorMaterialsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Materials'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
        itemBuilder: (context, index) => CustomMaterialContainer(
          txt1: materials[index].name,
          ontap: () {
            Navigator.pushNamed(
              context,
              InstructorMaterialDetailsScreen.routeName,
            );
          },
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: ScreenSize.height * 0.006),
        itemCount: materials.length,
      ),
    );
  }
}
