import 'package:ebn_el_hytham/core/utils/color_guid.dart';
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
    // elements[0..2] = header row, rest = data
    final int dataRowCount = ((elements.length - 3) / 3).ceil();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorGuid.glassBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          backgroundColor: ColorGuid.scaffoldBackgroundColor,
          collapsedBackgroundColor: ColorGuid.surfaceColor,
          shape: const Border(),
          collapsedShape: const Border(),
          iconColor: ColorGuid.amber,
          collapsedIconColor: ColorGuid.textSecondary,
          tilePadding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.05,
            vertical: ScreenSize.height * 0.004,
          ),
          title: Text(
            'Semester $index',
            style: TextStyle(
              color: ColorGuid.textPrimary,
              fontSize: ScreenSize.height * 0.021,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // GPA chip
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.03,
                  vertical: ScreenSize.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: ColorGuid.amber.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: ColorGuid.amber.withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Text(
                  gpa,
                  style: TextStyle(
                    color: ColorGuid.amber,
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
            // ── Divider between header and grid ──────────────────
            Divider(height: 1, thickness: 1, color: ColorGuid.glassBorder),
            // ── Header row ────────────────────────────────────────
            _buildHeaderRow(),
            // ── Divider ───────────────────────────────────────────
            Divider(height: 1, thickness: 1, color: ColorGuid.glassBorder),
            // ── Data rows ─────────────────────────────────────────
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataRowCount,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 1,
                color: ColorGuid.boardersColor.withOpacity(0.5),
              ),
              itemBuilder: (context, rowIndex) {
                final base = 3 + rowIndex * 3; // skip header
                final subject = elements[base];
                final code = elements[base + 1];
                final grade = elements[base + 2];
                return _buildDataRow(subject, code, grade, rowIndex);
              },
            ),
            SizedBox(height: ScreenSize.height * 0.008),
          ],
        ),
      ),
    );
  }

  // ── Header row widget ────────────────────────────────────────────────
  Widget _buildHeaderRow() {
    const headers = ['Subject', 'Code', 'Grade'];
    return Container(
      color: ColorGuid.scaffoldBackgroundColor,
      child: Row(
        children: List.generate(headers.length, (i) {
          return Expanded(
            flex: i == 0 ? 4 : 3, // Subject column wider
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.013,
                horizontal: ScreenSize.width * 0.02,
              ),
              child: Text(
                headers[i],
                textAlign: i == 0 ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  color: ColorGuid.amber,
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

  // ── Data row widget ──────────────────────────────────────────────────
  Widget _buildDataRow(
    String subject,
    String code,
    String grade,
    int rowIndex,
  ) {
    final bool isAlt = rowIndex.isOdd;
    return Container(
      color: isAlt
          ? ColorGuid.surfaceColor.withOpacity(0.6)
          : ColorGuid.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Subject
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
                  color: ColorGuid.textPrimary,
                  fontSize: ScreenSize.height * 0.017,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Vertical divider
          _vDivider(),
          // Code
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
                  color: ColorGuid.textSecondary,
                  fontSize: ScreenSize.height * 0.016,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          // Vertical divider
          _vDivider(),
          // Grade
          Expanded(flex: 3, child: Center(child: _gradeChip(grade))),
        ],
      ),
    );
  }

  Widget _vDivider() => Container(
    width: 1,
    height: ScreenSize.height * 0.055,
    color: ColorGuid.boardersColor.withOpacity(0.5),
  );

  // Grade chip — colored by pass/fail/pending
  Widget _gradeChip(String grade) {
    final Color chipColor;
    final Color textColor;

    if (grade == 'N/A' || grade.isEmpty) {
      chipColor = ColorGuid.textSecondary.withOpacity(0.1);
      textColor = ColorGuid.textSecondary;
    } else {
      // A+/A/B → greenish, C/D → amber, F → red
      final upper = grade.toUpperCase();
      if (upper.startsWith('A') || upper.startsWith('B')) {
        chipColor = const Color(0xFF1A3A2A);
        textColor = const Color(0xFF4CAF50);
      } else if (upper.startsWith('C') || upper.startsWith('D')) {
        chipColor = ColorGuid.amber.withOpacity(0.12);
        textColor = ColorGuid.amber;
      } else if (upper == 'F') {
        chipColor = const Color(0xFF3A1A1A);
        textColor = const Color(0xFFEF5350);
      } else {
        chipColor = ColorGuid.amber.withOpacity(0.12);
        textColor = ColorGuid.amber;
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
