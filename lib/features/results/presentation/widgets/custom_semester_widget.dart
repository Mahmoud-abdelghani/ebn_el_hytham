import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/results/data/models/student_result_model.dart';
import 'package:flutter/material.dart';

/// Expandable semester result widget with dark grid of grades.
/// [surfaceColor] card, [amber] semester GPA, dark grid cells.
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        // [surfaceColor] dark card
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: ColorGuid.scaffoldBackgroundColor.withOpacity(0.5),
        collapsedBackgroundColor: Colors.transparent,
        shape: const Border(),
        collapsedShape: const Border(),
        // [amber] icon when expanded, [textSecondary] when collapsed
        iconColor: ColorGuid.amber,
        collapsedIconColor: ColorGuid.textSecondary,
        title: Text(
          'Semester $index',
          style: TextStyle(
            color: ColorGuid.textPrimary, // [textPrimary] white
            fontSize: ScreenSize.height * 0.022,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Semester GPA in [amber]
            Text(
              civilStudentResults.semestersResults[index - 1].semesterGpa,
              style: TextStyle(
                color: ColorGuid.amber,
                fontSize: ScreenSize.height * 0.022,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.02),
            // Arrow icon handled by ExpansionTile (will be amber)
          ],
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
                  // Alternating slightly lighter surface for grid cells
                  color: index.isEven
                      ? ColorGuid.surfaceColor
                      : ColorGuid.scaffoldBackgroundColor,
                  border: Border.all(
                    color: ColorGuid.boardersColor, // [boardersColor] grid lines
                    width: 0.7,
                  ),
                ),
                child: Text(
                  elements[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenSize.height * 0.018,
                    // Header row in [amber], data rows in [textPrimary]
                    color: index < 3 ? ColorGuid.amber : ColorGuid.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
