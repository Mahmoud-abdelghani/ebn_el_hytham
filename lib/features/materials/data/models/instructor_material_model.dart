import 'package:ebn_el_hytham/features/materials/data/models/assigned_material_model.dart';
import 'package:ebn_el_hytham/features/materials/data/models/enrolled_material_student_model.dart';

class InstructorMaterialModel {
  final String name;
  final String code;
  final String day;
  final String departmentName;
  final String level;
  final String location;
  final String startingPeriod;
  final String time;

  List <EnrolledMaterialStudentModel> assignedMaterials ;

  InstructorMaterialModel({
    required this.name,
    required this.code,
    required this.day,
    required this.departmentName,
    required this.level,
    required this.location,
    required this.startingPeriod,
    required this.time,
    required this.assignedMaterials,
  });


   factory InstructorMaterialModel.fromJson({
    required Map<String, dynamic> teacherCourse,   // من /teacher/{id}
    required Map<String, dynamic> dashboardCourse, // من /instructor/dashboard/{id}
  }) {
    final period = teacherCourse['period'] as Map<String, dynamic>? ?? {};

    final students = (dashboardCourse['enrolled_students'] as List<dynamic>? ?? [])
        .map((s) => EnrolledMaterialStudentModel.fromJson(s as Map<String, dynamic>))
        .toList();

    return InstructorMaterialModel(
      name: teacherCourse['course_name'] as String? ?? '',
      code: teacherCourse['course_code'] as String? ?? '',
      day: teacherCourse['day'] as String? ?? '',
      departmentName: teacherCourse['dept_name'] as String? ?? '',
      level: teacherCourse['level'] as String? ?? '',
      location: teacherCourse['location'] as String? ?? '',
      startingPeriod: '${period['from']} → ${period['to']}',
      time: teacherCourse['time'] as String? ?? '',
      assignedMaterials: students,
    );
  }

  /// بيعمل match بين الـ courses من الـ API الاتنين عن طريق course_code
  static List<InstructorMaterialModel> fromBothApis({
    required Map<String, dynamic> teacherResponse,
    required Map<String, dynamic> dashboardResponse,
  }) {
    final teacherCourses = teacherResponse['assigned_courses'] as List<dynamic>? ?? [];
    final dashboardCourses = dashboardResponse['courses'] as List<dynamic>? ?? [];

    // بنعمل map من course_code → dashboard course عشان الـ lookup يبقى O(1)
    final dashboardMap = {
      for (final c in dashboardCourses)
        (c as Map<String, dynamic>)['course_code'] as String: c
    };

    return teacherCourses.map((tc) {
      final teacherCourse = tc as Map<String, dynamic>;
      final code = teacherCourse['course_code'] as String;
      final dashboardCourse = dashboardMap[code] ?? {};

      return InstructorMaterialModel.fromJson(
        teacherCourse: teacherCourse,
        dashboardCourse: dashboardCourse,
      );
    }).toList();
  }
}

