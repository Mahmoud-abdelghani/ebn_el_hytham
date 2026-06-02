class InstructorModel {
  final String name;
  final String email;
  final String department;
  final String id;
  final String nationalId;
  final String createdAt;
  final String totalAssignedCourses;
  final List<String> assignedMaterials;

  InstructorModel({
    required this.name,
    required this.email,
    required this.department,
    required this.id,
    required this.nationalId,
    required this.createdAt,
    required this.totalAssignedCourses,
    required this.assignedMaterials,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      id: json['id'].toString(),
      nationalId: json['national_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      totalAssignedCourses:
          (json['assigned_courses'] as List?)?.length.toString() ?? '0',
      assignedMaterials: List.generate(
        (json['assigned_courses'] as List? ?? []).length,
        (index) => json['assigned_courses'][index]['course_name'],
      ),
    );
  }
}
