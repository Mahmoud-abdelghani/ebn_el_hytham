class InstructorMateriaTableModel {
  final String courseName;
  final String courseCode;
  final String day;
  final String lectureLocation;
  final int startingPeriod;
  final String time;

  InstructorMateriaTableModel({
    required this.courseName,
    required this.courseCode,
    required this.day,
    required this.lectureLocation,
    required this.startingPeriod,
    required this.time,
  });
  factory InstructorMateriaTableModel.fromJson(Map<String, dynamic> json) {
    return InstructorMateriaTableModel(
      courseName: json['course_name'] as String,
      courseCode: json['course_code'] as String,
      day: json['day'] as String,
      lectureLocation: json['location'] as String,
      startingPeriod: json['period']['from'] as int,
      time: json['time'] as String,
    );
  }
}
