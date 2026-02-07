class StudentMarkModel {
  final String studentName;
  final String studentId;
   double mark;

  StudentMarkModel({
    required this.studentName,
    required this.studentId,
    required this.mark,
  });
  void addbonus(int amount) {
    mark += amount;
  }
}
