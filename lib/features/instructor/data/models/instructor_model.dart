class InstructorModel {
  final String name;
  final String email;
  final String photo;
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
    required this.photo,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      photo:
          'https://tse2.mm.bing.net/th/id/OIP.OPC0yG5gmciVcOl_Uruz-AHaFj?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
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
