import 'package:ebn_el_hytham/core/api/end_points.dart';

class MaterialModel {
  final String corseCode;
  final String corseName;
  final int hours;
  final String grade;
  MaterialModel({
    required this.corseCode,
    required this.corseName,
    required this.hours,
    required this.grade,
  });
  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
    corseName: json[ApiKeys.materialName],
    corseCode: json[ApiKeys.courseCode],
    hours: json[ApiKeys.creditHours],
    grade: json[ApiKeys.result] ?? 'N/A',
  );
}
