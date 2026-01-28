import 'dart:developer';

import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/laiha/data/models/student_holy_laiha_model.dart';
import 'package:ebn_el_hytham/features/military/presentation/widgets/custom_data_container.dart';
import 'package:flutter/material.dart';

class LayhaView extends StatefulWidget {
  const LayhaView({super.key});
  static const String routename = 'LayhaView';
  @override
  State<LayhaView> createState() => _LayhaViewState();
}

class _LayhaViewState extends State<LayhaView> {
  String selected = 'Semester 1';
  int semesterNum = 0;
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
          'اللايحه',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.05)),
          SliverToBoxAdapter(
            child: CustomDataContainer(
              data: studentHolyLaiha.department,
              textDirection: TextDirection.ltr,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.05)),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                showMenu(
                  color: Colors.transparent,
                  context: context,
                  position: RelativeRect.fromDirectional(
                    textDirection: TextDirection.ltr,
                    start: 0,
                    top: ScreenSize.height * 0.3,
                    end: ScreenSize.width,
                    bottom: ScreenSize.height,
                  ),
                  items: List.generate(
                    studentHolyLaiha.layhaSemesters.length,
                    (index) => PopupMenuItem(
                      onTap: () {
                        log('${index + 1}');
                        selected = 'Semester ${index + 1}';
                        semesterNum = index;
                        setState(() {});
                      },
                      child: CustomDataContainer(
                        data: 'Semester ${index + 1}',
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                );
              },
              child: CustomDataContainer(
                data: selected,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.05)),
          SliverList.separated(
            itemBuilder: (context, index) => ExpansionTile(
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              title: Text(
                studentHolyLaiha
                    .layhaSemesters[semesterNum]
                    .semesterMaterials[index]
                    .materialName,
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontSize: ScreenSize.height * 0.025,
                  fontWeight: FontWeight.w400,
                ),
              ),
              children: [
                SizedBox(
                  width: ScreenSize.width,
                  height:
                      ScreenSize.height *
                      0.1 *
                      studentHolyLaiha
                          .layhaSemesters[semesterNum]
                          .semesterMaterials[index]
                          .dependentMaterials
                          .length,
                  child: ListView.builder(
                    itemCount: studentHolyLaiha
                        .layhaSemesters[semesterNum]
                        .semesterMaterials[index]
                        .dependentMaterials
                        .length,
                    itemBuilder: (context, index2) => CustomDataContainer(
                      data: studentHolyLaiha
                          .layhaSemesters[semesterNum]
                          .semesterMaterials[index]
                          .dependentMaterials[index2],
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ],
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.01),
            itemCount: studentHolyLaiha
                .layhaSemesters[semesterNum]
                .semesterMaterials
                .length,
          ),
        ],
      ),
    );
  }
}
