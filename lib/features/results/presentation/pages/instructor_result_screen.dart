import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_material_container.dart';
import 'package:ebn_el_hytham/features/results/data/models/instructor_material_result.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_details_result_screen.dart';
import 'package:flutter/material.dart';

class InstructorResultScreen extends StatelessWidget {
  const InstructorResultScreen({super.key});
  static const String routeName = 'InstructorResultScreen';
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
          'Results',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => CustomMaterialContainer(
          txt1: listOfResults[index].materialName,
          ontap: () {
            Navigator.pushNamed(
              context,
              InstructorDetailsResultScreen.routeName,
              arguments: index,
            );
          },
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: ScreenSize.height * 0.02),
        itemCount: listOfResults.length,
      ),
    );
  }
}
