import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomSemesterWidget extends StatelessWidget {
  const CustomSemesterWidget({
    super.key,
    required this.elements,
    required this.index,
    required this.gpa,
  });

  final List<String> elements;
  final int index;
  final String gpa;

  @override
  Widget build(BuildContext context) {
    final int dataRowCount = ((elements.length - 3) / 3).ceil();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.glassBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          backgroundColor: context.scaffold,
          collapsedBackgroundColor: context.surface,
          shape: const Border(),
          collapsedShape: const Border(),
          iconColor: context.accent,
          collapsedIconColor: context.onSurfaceMuted,
          tilePadding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.05,
            vertical: ScreenSize.height * 0.004,
          ),
          title: Text(
            'Semester $index',
            style: TextStyle(
              color: context.onBackground,
              fontSize: ScreenSize.height * 0.021,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.03,
                  vertical: ScreenSize.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: context.accentSubtle,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: context.accentBorder,
                    width: 1,
                  ),
                ),
                child: Text(
                  gpa,
                  style: TextStyle(
                    color: context.accent,
                    fontSize: ScreenSize.height * 0.02,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.02),
            ],
          ),
          children: [
            Divider(height: 1, thickness: 1, color: context.glassBorder),
            _buildHeaderRow(context),
            Divider(height: 1, thickness: 1, color: context.glassBorder),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataRowCount,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 1,
                color: context.cardBorder.withOpacity(0.5),
              ),
              itemBuilder: (context, rowIndex) {
                final base = 3 + rowIndex * 3;
                final subject = elements[base];
                final code = elements[base + 1];
                final grade = elements[base + 2];
                return _buildDataRow(context, subject, code, grade, rowIndex);
              },
            ),
            SizedBox(height: ScreenSize.height * 0.008),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    const headers = ['Subject', 'Code', 'Grade'];
    return Container(
      color: context.scaffold,
      child: Row(
        children: List.generate(headers.length, (i) {
          return Expanded(
            flex: i == 0 ? 4 : 3,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.013,
                horizontal: ScreenSize.width * 0.02,
              ),
              child: Text(
                headers[i],
                textAlign: i == 0 ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  color: context.accent,
                  fontSize: ScreenSize.height * 0.016,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDataRow(
    BuildContext context,
    String subject,
    String code,
    String grade,
    int rowIndex,
  ) {
    final bool isAlt = rowIndex.isOdd;
    return Container(
      color: isAlt
          ? context.surface.withOpacity(0.6)
          : context.scaffold,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.015,
                horizontal: ScreenSize.width * 0.03,
              ),
              child: Text(
                subject,
                style: TextStyle(
                  color: context.onBackground,
                  fontSize: ScreenSize.height * 0.017,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          _vDivider(context),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.015,
              ),
              child: Text(
                code,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.onSurfaceMuted,
                  fontSize: ScreenSize.height * 0.016,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          _vDivider(context),
          Expanded(flex: 3, child: Center(child: _gradeChip(context, grade))),
        ],
      ),
    );
  }

  Widget _vDivider(BuildContext context) => Container(
    width: 1,
    height: ScreenSize.height * 0.055,
    color: context.cardBorder.withOpacity(0.5),
  );

  Widget _gradeChip(BuildContext context, String grade) {
    final Color chipColor;
    final Color textColor;

    if (grade == 'N/A' || grade.isEmpty) {
      chipColor = context.onSurfaceMuted.withOpacity(0.1);
      textColor = context.onSurfaceMuted;
    } else {
      final upper = grade.toUpperCase();
      if (upper.startsWith('A') || upper.startsWith('B')) {
        chipColor = const Color(0xFF1A3A2A);
        textColor = const Color(0xFF4CAF50);
      } else if (upper.startsWith('C') || upper.startsWith('D')) {
        chipColor = context.accentSubtle;
        textColor = context.accent;
      } else if (upper == 'F') {
        chipColor = const Color(0xFF3A1A1A);
        textColor = const Color(0xFFEF5350);
      } else {
        chipColor = context.accentSubtle;
        textColor = context.accent;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.025,
        vertical: ScreenSize.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        grade.isEmpty ? 'N/A' : grade,
        style: TextStyle(
          color: textColor,
          fontSize: ScreenSize.height * 0.016,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
