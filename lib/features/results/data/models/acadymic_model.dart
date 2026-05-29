
import 'package:ebn_el_hytham/core/api/end_points.dart';
import 'package:ebn_el_hytham/features/results/data/models/material_model.dart';
import 'package:ebn_el_hytham/features/results/data/models/semester_model.dart';

class AcadymicModel {
  final double cgba;
  final List<double> listOfSemesterGpas;
  final List<int> semesterHours;
  final List<SemesterModel> listOfSemesters;
  AcadymicModel({
    required this.cgba,
    required this.listOfSemesterGpas,
    required this.semesterHours,
    required this.listOfSemesters,
  });

  factory AcadymicModel.fromJson(Map<String, dynamic> json) => AcadymicModel(
    cgba: json[ApiKeys.data]['CGPA'],
    listOfSemesterGpas:
        (json[ApiKeys.data][ApiKeys.sGPA] as Map<String, dynamic>).values
            .map((e) => e as double)
            .toList(),
    semesterHours:
        (json[ApiKeys.data][ApiKeys.totalCreditHoursPerSemester]
                as Map<String, dynamic>)
            .values
            .map((e) => e as int)
            .toList(),
    listOfSemesters: List.generate(
      (json[ApiKeys.data][ApiKeys.materials] as Map<String, dynamic>)
          .keys
          .length,
      (index) => SemesterModel(
        semesterName: 'Semester ${index + 1}',
        listOfMaterials:
            (json[ApiKeys.data][ApiKeys.materials]['semester${index + 1}']
                    as List)
                .map((e) => MaterialModel.fromJson(e))
                .toList(),
      ),
    ),
  );
}
