import 'package:ebn_el_hytham/features/results/data/models/student_mark_model.dart';

class InstructorMaterialResult {
  final String materialName;
  final String department;
  final String season;
  final String examDate;
  final String totalStrudent;
  final String totalNumberSuccess;
  final String totalNumberFail;
  List<StudentMarkModel> listStudentMark;
  InstructorMaterialResult({
    required this.materialName,
    required this.department,
    required this.season,
    required this.examDate,
    required this.totalStrudent,
    required this.totalNumberSuccess,
    required this.totalNumberFail,
    required this.listStudentMark,
  });
  void addBonus(int amount) {
    listStudentMark.map((e) => e.addbonus(amount)).toList();
  }
}

List<InstructorMaterialResult> listOfResults = [
  InstructorMaterialResult(
    materialName: "Engineering Mathematics I",
    department: "Civil Engineering",
    season: "Summer",
    examDate: "15/08/2023",
    totalStrudent: "120",
    totalNumberSuccess: "110",
    totalNumberFail: "10",
    listStudentMark: [
      StudentMarkModel(
        studentName: "Ahmed Ali",
        studentId: "CE2023001",
        mark: 65.15,
      ),
      StudentMarkModel(
        studentName: "Sara Mohamed",
        studentId: "CE2023002",
        mark: 28.0,
      ),
      StudentMarkModel(
        studentName: "Omar Hassan",
        studentId: "CE2023003",
        mark: 56.0,
      ),
      StudentMarkModel(
        studentName: "Laila Youssef",
        studentId: "CE2023004",
        mark: 42.0,
      ),
      StudentMarkModel(
        studentName: "Khaled Ibrahim",
        studentId: "CE2023005",
        mark: 19.0,
      ),
    ],
  ),
  InstructorMaterialResult(
    materialName: 'Anntena',
    department: 'Communications and electroneics',
    season: 'Spring',
    examDate: '10/05/2023',
    totalStrudent: '85',
    totalNumberSuccess: '78',
    totalNumberFail: '7',
    listStudentMark: [
      StudentMarkModel(
        studentName: "Mona Adel",
        studentId: "CE2023010",
        mark: 51.0,
      ),
      StudentMarkModel(
        studentName: "Tamer Fathy",
        studentId: "CE2023011",
        mark: 34.0,
      ),
      StudentMarkModel(
        studentName: "Nadia Samir",
        studentId: "CE2023012",
        mark: 23.0,
      ),
    ],
  ),
];
