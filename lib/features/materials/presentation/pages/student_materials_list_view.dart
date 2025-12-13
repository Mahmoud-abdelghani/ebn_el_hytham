import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_material_details_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_material_container.dart';
import 'package:flutter/material.dart';

class StudentMaterialsListView extends StatelessWidget {
  const StudentMaterialsListView({super.key});
  static const String routeName = 'StudentMaterialsListView';

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
          "Materials",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => CustomMaterialContainer(
                txt1: mechanicalMaterials[index].name,
                ontap: () {
                  Navigator.pushNamed(
                    context,
                    StudentMaterialDetailsView.routeName,
                    arguments: mechanicalMaterials[index],
                  );
                },
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: ScreenSize.height * 0.01),
              itemCount: mechanicalMaterials.length,
            ),
          ),
        ],
      ),
    );
  }
}
