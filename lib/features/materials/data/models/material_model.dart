class MaterialModel {
  final String name;
  final String code;
  final String doctorName;
  final String doctorEmail;
  final String lectureDate;
  final String attendanceDegree;
  final String midDegree;
  final String labsDegree;
  final String section;
  final String lectureLocation;
  final String numberOfHours;

  MaterialModel({
    required this.name,
    required this.code,
    required this.doctorName,
    required this.doctorEmail,
    required this.lectureDate,
    required this.attendanceDegree,
    required this.midDegree,
    required this.labsDegree,
    required this.section,
    required this.lectureLocation,
    required this.numberOfHours,
  });
}

final List<MaterialModel> mechanicalMaterials = [
  MaterialModel(
    name: "Thermodynamics II",
    code: "ME322",
    doctorName: "Dr. Ahmed El-Sayed",
    doctorEmail: "ahmed.elsayed@alexu.edu.eg",
    lectureDate: "Sunday 10:00 AM",
    attendanceDegree: "10",
    midDegree: "30",
    labsDegree: "20",
    section: "Section 3",
    lectureLocation: "Hall 5 - Mechanical Building",
    numberOfHours: "3",
  ),

  MaterialModel(
    name: "Fluid Mechanics I",
    code: "ME211",
    doctorName: "Dr. Mohamed Soliman",
    doctorEmail: "m.soliman@alexu.edu.eg",
    lectureDate: "Tuesday 12:00 PM",
    attendanceDegree: "10",
    midDegree: "25",
    labsDegree: "15",
    section: "Section 2",
    lectureLocation: "Hall 3 - Mechanical Building",
    numberOfHours: "3",
  ),

  MaterialModel(
    name: "Mechanics of Materials",
    code: "ME231",
    doctorName: "Dr. Hany El-Kady",
    doctorEmail: "hany.elkady@alexu.edu.eg",
    lectureDate: "Wednesday 9:00 AM",
    attendanceDegree: "10",
    midDegree: "30",
    labsDegree: "20",
    section: "Section 1",
    lectureLocation: "Hall 2",
    numberOfHours: "3",
  ),

  MaterialModel(
    name: "Machine Design I",
    code: "ME341",
    doctorName: "Dr. Sherif Hassan",
    doctorEmail: "s.hassan@alexu.edu.eg",
    lectureDate: "Monday 11:00 AM",
    attendanceDegree: "10",
    midDegree: "25",
    labsDegree: "15",
    section: "Section 4",
    lectureLocation: "Hall 6",
    numberOfHours: "3",
  ),

  MaterialModel(
    name: "Manufacturing Processes",
    code: "ME251",
    doctorName: "Dr. Mostafa El-Naggar",
    doctorEmail: "mostafa.elnaggar@alexu.edu.eg",
    lectureDate: "Thursday 1:00 PM",
    attendanceDegree: "10",
    midDegree: "20",
    labsDegree: "20",
    section: "Section 5",
    lectureLocation: "Workshop 2",
    numberOfHours: "3",
  ),
];
