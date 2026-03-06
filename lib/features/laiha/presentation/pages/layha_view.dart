import 'dart:developer';

import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
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
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('اللايحه'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.03)),
          // Department info card
          SliverToBoxAdapter(
            child: CustomDataContainer(
              data: studentHolyLaiha.department,
              textDirection: TextDirection.ltr,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
          // Semester picker — tapping opens a dark popup menu
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                showMenu(
                  // [surfaceColor] transparent background — popup items style themselves
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
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
          // Material expansion list — dark themed
          SliverList.separated(
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.035),
              decoration: BoxDecoration(
                // [surfaceColor] expansion tile card
                color: ColorGuid.surfaceColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
              ),
              child: ExpansionTile(
                backgroundColor: ColorGuid.scaffoldBackgroundColor.withOpacity(0.5),
                collapsedBackgroundColor: Colors.transparent,
                shape: const Border(),
                collapsedShape: const Border(),
                title: Text(
                  studentHolyLaiha
                      .layhaSemesters[semesterNum]
                      .semesterMaterials[index]
                      .materialName,
                  style: TextStyle(
                    color: ColorGuid.textPrimary, // [textPrimary] white
                    fontSize: ScreenSize.height * 0.022,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // [amber] expansion arrow
                iconColor: ColorGuid.amber,
                collapsedIconColor: ColorGuid.textSecondary,
                children: [
                  SizedBox(
                    width: ScreenSize.width,
                    height: ScreenSize.height *
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
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: ScreenSize.height * 0.01),
            itemCount: studentHolyLaiha
                .layhaSemesters[semesterNum]
                .semesterMaterials
                .length,
          ),
          SliverToBoxAdapter(child: SizedBox(height: ScreenSize.height * 0.02)),
        ],
      ),
    );
  }
}
