class EnrolledMaterialStudentModel {
  final String id;
  final String name;
  final String email;
  int yearWork;
  int finalDegree;
  int total;

  EnrolledMaterialStudentModel({
    required this.id,
    required this.name,
    required this.email,
    this.yearWork = 0,
    this.finalDegree = 0,
    this.total = 0,
  });

  factory EnrolledMaterialStudentModel.fromJson(Map<String, dynamic> json) {
    final grades = json['grades'] as Map<String, dynamic>? ?? {};
    final yearWork = (grades['year_work'] as num?)?.toInt() ?? 0;
    final finalDegree = (grades['final_exam'] as num?)?.toInt() ?? 0;

    return EnrolledMaterialStudentModel(
      id: json['id'].toString(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      yearWork: yearWork,
      finalDegree: finalDegree,
      total: yearWork + finalDegree,
    );
  }
}
