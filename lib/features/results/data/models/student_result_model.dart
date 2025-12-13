import 'package:ebn_el_hytham/features/results/data/models/material_result_model.dart';
import 'package:ebn_el_hytham/features/results/data/models/semester_model.dart';

class StudentResultModel {
  final String totalGpa;
  final List<SemesterModel> semestersResults;

  StudentResultModel({required this.totalGpa, required this.semestersResults});
}

final StudentResultModel civilStudentResults = StudentResultModel(
  totalGpa: "3.41",
  semestersResults: [
    // -----------------  SEMESTER 1  -----------------
    SemesterModel(
      semesterGpa: "3.30",
      listMaterialsResults: [
        MaterialResultModel(
          name: "Engineering Mathematics I",
          code: "CE101",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Engineering Mechanics (Statics)",
          code: "CE102",
          grad: "B+",
        ),
        MaterialResultModel(
          name: "Introduction to Civil Engineering",
          code: "CE103",
          grad: "A-",
        ),
        MaterialResultModel(
          name: "Engineering Drawing",
          code: "CE104",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Physics for Engineers",
          code: "CE105",
          grad: "B",
        ),
        MaterialResultModel(
          name: "Chemistry for Engineers",
          code: "CE106",
          grad: "A",
        ),
      ],
    ),

    // -----------------  SEMESTER 2  -----------------
    SemesterModel(
      semesterGpa: "3.45",
      listMaterialsResults: [
        MaterialResultModel(
          name: "Engineering Mathematics II",
          code: "CE201",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Strength of Materials I",
          code: "CE202",
          grad: "B+",
        ),
        MaterialResultModel(name: "Surveying I", code: "CE203", grad: "A"),
        MaterialResultModel(name: "Fluid Mechanics", code: "CE204", grad: "A-"),
        MaterialResultModel(
          name: "Computer Programming for Engineers",
          code: "CE205",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Civil Engineering Materials",
          code: "CE206",
          grad: "B+",
        ),
      ],
    ),

    // -----------------  SEMESTER 3  -----------------
    SemesterModel(
      semesterGpa: "3.50",
      listMaterialsResults: [
        MaterialResultModel(
          name: "Strength of Materials II",
          code: "CE301",
          grad: "A",
        ),
        MaterialResultModel(name: "Surveying II", code: "CE302", grad: "A-"),
        MaterialResultModel(
          name: "Structural Analysis I",
          code: "CE303",
          grad: "A",
        ),
        MaterialResultModel(name: "Hydraulics", code: "CE304", grad: "B+"),
        MaterialResultModel(name: "Soil Mechanics I", code: "CE305", grad: "A"),
        MaterialResultModel(
          name: "Concrete Technology",
          code: "CE306",
          grad: "A",
        ),
      ],
    ),

    // -----------------  SEMESTER 4  -----------------
    SemesterModel(
      semesterGpa: "3.38",
      listMaterialsResults: [
        MaterialResultModel(
          name: "Structural Analysis II",
          code: "CE401",
          grad: "A-",
        ),
        MaterialResultModel(
          name: "Reinforced Concrete I",
          code: "CE402",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Transportation Engineering",
          code: "CE403",
          grad: "B+",
        ),
        MaterialResultModel(
          name: "Soil Mechanics II",
          code: "CE404",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Environmental Engineering",
          code: "CE405",
          grad: "A",
        ),
        MaterialResultModel(
          name: "Engineering Economy",
          code: "CE406",
          grad: "A-",
        ),
      ],
    ),
  ],
);

