import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/enrolled_material_student_model.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final EnrolledMaterialStudentModel student;
  final int index;
  final int materialIndex;
  final VoidCallback onEdit;

  const StudentTile({
    super.key,
    required this.student,
    required this.index,
    required this.materialIndex,
    required this.onEdit,
  });

  Color _gradeColor(BuildContext context) {
    if (student.total >= 85) return const Color(0xFF81C784);
    if (student.total >= 60) return context.accent;
    if (student.total >= 50) return const Color(0xFFFFB74D);
    return const Color(0xFFEF5350);
  }

  @override
  Widget build(BuildContext context) {
    final gradeColor = _gradeColor(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.013,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: ScreenSize.height * 0.04,
            height: ScreenSize.height * 0.04,
            decoration: BoxDecoration(
              color: context.scaffold,
              shape: BoxShape.circle,
              border: Border.all(color: context.glassBorder),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: context.textMuted,
                  fontSize: ScreenSize.height * 0.013,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: ScreenSize.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextStyle(
                    color: context.onBackground,
                    fontSize: ScreenSize.height * 0.016,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  student.id,
                  style: TextStyle(
                    color: context.textMuted,
                    fontSize: ScreenSize.height * 0.013,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.025,
                  vertical: ScreenSize.height * 0.004,
                ),
                decoration: BoxDecoration(
                  color: gradeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Total: ${student.total}',
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: ScreenSize.height * 0.013,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.height * 0.004),
              Text(
                'YW: ${student.yearWork}  |  Final: ${student.finalDegree}',
                style: TextStyle(
                  color: context.textMuted,
                  fontSize: ScreenSize.height * 0.012,
                ),
              ),
            ],
          ),
          SizedBox(width: ScreenSize.width * 0.025),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // TODO: send email to student
                },
                child: Icon(Icons.email_outlined,
                    color: const Color(0xFF64B5F6),
                    size: ScreenSize.height * 0.022),
              ),
              SizedBox(height: ScreenSize.height * 0.008),
              GestureDetector(
                onTap: onEdit,
                child: Icon(Icons.edit_outlined,
                    color: context.accent,
                    size: ScreenSize.height * 0.022),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
