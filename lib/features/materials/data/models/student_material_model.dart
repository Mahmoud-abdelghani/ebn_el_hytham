import 'package:ebn_el_hytham/features/materials/data/models/material_model.dart';
import 'package:flutter/material.dart';

class StudentMaterialModel {
  final String studentName;
  final String studentId;
  final String urlImage;
  final MaterialModel materialDetails;

  StudentMaterialModel({required this.studentName, required this.studentId, required this.urlImage, required this.materialDetails});
  
}
