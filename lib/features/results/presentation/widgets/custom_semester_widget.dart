import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/results/data/models/student_result_model.dart';
import 'package:flutter/material.dart';

class CustomSemesterWidget extends StatelessWidget {
  const CustomSemesterWidget({
    super.key,
    required this.elements,
    required this.index,
  });
  final List<String> elements;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,

      collapsedBackgroundColor: Colors.white,
      title: Text(
        'Semester $index',
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.03,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Text(
        civilStudentResults.semestersResults[index - 1].semesterGpa,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.03,
          fontWeight: FontWeight.w400,
        ),
      ),
      children: [
        SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.4,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: ScreenSize.height * .00001,
              mainAxisExtent: ScreenSize.height * 0.09,
            ),
            itemCount: elements.length,
            itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ColorGuid.mainColor,
                  width: ScreenSize.height * .001,
                ),
              ),
              child: Text(
                elements[index],
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.02,
                  color: ColorGuid.mainColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
