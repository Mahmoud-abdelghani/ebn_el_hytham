

import 'package:ebn_el_hytham/features/results/data/models/material_model.dart';

class SemesterModel {
  final String semesterName;
  final List<MaterialModel> listOfMaterials;
  SemesterModel({required this.semesterName, required this.listOfMaterials});
  factory SemesterModel.fromJson(
    List<Map<String, dynamic>> json,
    String studentId,
  ) => SemesterModel(
    semesterName: studentId,
    listOfMaterials: json.map((e) => MaterialModel.fromJson(e)).toList(),
  );
}
