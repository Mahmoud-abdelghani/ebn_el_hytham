class AssignedMaterialModel {
  final String name;
  final String code;
  final String hours;
  final String instructorName;
  final String instructorEmail;
  final String lectureLocation;
  final String lectureTime;
  final String startingPeriod;
  final String yearWork;
  final String finalDegree;
  final String total;
  final String grade;
  final String day;

  AssignedMaterialModel({
    required this.name,
    required this.code,
    required this.hours,
    required this.instructorName,
    required this.instructorEmail,
    required this.lectureLocation,
    required this.lectureTime,
    required this.startingPeriod,
    required this.yearWork,
    required this.finalDegree,
    required this.total,
    required this.grade,
    required this.day,
  });

  factory AssignedMaterialModel.fromJson(Map<String, dynamic> json) {
    final schedule = json['schedule'] as Map<String, dynamic>? ?? {};
    final teacher = json['teacher'] as Map<String, dynamic>? ?? {};
    final results = json['results'] as Map<String, dynamic>? ?? {};
    final period = schedule['period'] as Map<String, dynamic>? ?? {};

    return AssignedMaterialModel(
      name: json['course_name'] as String? ?? 'No data yet',
      code: json['course_code'] as String? ?? 'No data yet',
      hours: json['credit_hours']?.toString() ?? 'No data yet',
      instructorName: teacher['name'] as String? ?? 'No data yet',
      instructorEmail: teacher['email'] as String? ?? 'No data yet',
      lectureLocation: schedule['location'] as String? ?? 'No data yet',
      lectureTime: schedule['time'] as String? ?? 'No data yet',
      startingPeriod: period['from']?.toString() ?? 'No data yet',
      yearWork: results['year_work']?.toString() ?? 'No data yet',
      finalDegree: results['final_exam']?.toString() ?? 'No data yet',
      total: results['total']?.toString() ?? 'No data yet',
      grade: results['grade'] as String? ?? 'No data yet',
      day: schedule['day'] as String? ?? 'No data yet',
    );
  }
}
