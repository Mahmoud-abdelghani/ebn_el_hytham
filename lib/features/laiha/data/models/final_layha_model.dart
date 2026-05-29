import 'package:ebn_el_hytham/features/laiha/data/models/material_layha_model.dart';

class FinalLayhaModel {
  final String department;
List<LevelModel> levels;
  FinalLayhaModel({required this.department,required this.levels});

  factory FinalLayhaModel.fromJson(Map<String, dynamic> json) {
    final progressByLevel = json['progress_by_level'] as Map<String, dynamic>;

    final levels = progressByLevel.entries.map((entry) {
      final materials = (entry.value as List<dynamic>)
          .map((e) => MaterialLayhaModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return LevelModel(level: entry.key, materials: materials);
    }).toList();

    return FinalLayhaModel(
      department: json['department'] as String,
      levels: levels,
    );
  }
}

class LevelModel{
  final String level;
  final List<MaterialLayhaModel> materials;
LevelModel({required this.level,required this.materials});

}
