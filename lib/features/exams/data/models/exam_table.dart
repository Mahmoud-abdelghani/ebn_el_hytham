import 'package:ebn_el_hytham/features/exams/data/models/exam_details_model.dart';

class ExamTable {
  final String nextExamName;
  final List<ExamDetailsModel> exams;

  ExamTable({required this.nextExamName, required this.exams});
}

final ExamTable civilExamTable = ExamTable(
  nextExamName: "Concrete Technology",
  exams: [
    ExamDetailsModel(
      name: "Soil Mechanics II",
      date: "2025-01-05 09:00 AM",
      location: "قاعة علوم",
      chairNum: "B-132",
    ),
    ExamDetailsModel(
      name: "Structural Analysis II",
      date: "2025-01-08 12:00 PM",
      location: "مدرج 3",
      chairNum: "A-089",
    ),
    ExamDetailsModel(
      name: "Concrete Technology",
      date: "2025-01-11 09:00 AM",
      location: "قاعة 2",
      chairNum: "C-045",
    ),
    ExamDetailsModel(
      name: "Hydraulics",
      date: "2025-01-14 12:00 PM",
      location: "مدرج 6",
      chairNum: "A-204",
    ),
    ExamDetailsModel(
      name: "Environmental Engineering",
      date: "2025-01-17 09:00 AM",
      location: "مدرج عمارة",
      chairNum: "B-076",
    ),
    ExamDetailsModel(
      name: "Transportation Engineering",
      date: "2025-01-20 12:00 PM",
      location: "قاعة 1",
      chairNum: "C-099",
    ),
  ],
);
