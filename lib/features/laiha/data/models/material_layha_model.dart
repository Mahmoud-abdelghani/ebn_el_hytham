import 'package:ebn_el_hytham/features/laiha/data/models/requirement_model.dart';

class MaterialLayhaModel {
  final String materialName;
  final String materialCode;
  final String status;
  final List<RequirementModel> requires;

  MaterialLayhaModel({
    required this.materialName,
    required this.materialCode,
    required this.status,
    required this.requires,
  });

   factory MaterialLayhaModel.fromJson(Map<String, dynamic> json) {
    return MaterialLayhaModel(
      materialName: json['course_name'] as String,
      materialCode: json['course_code'] as String,
      status: json['status'] as String,
      requires: (json['prerequisites'] as List<dynamic>)
          .map((e) => RequirementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
