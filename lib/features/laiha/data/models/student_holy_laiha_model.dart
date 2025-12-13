import 'package:ebn_el_hytham/features/laiha/data/models/layha_material_model.dart';
import 'package:ebn_el_hytham/features/laiha/data/models/layha_semester_model.dart';

class StudentHolyLaihaModel {
  final String department;
  final List<LayhaSemesterModel> layhaSemesters;

  StudentHolyLaihaModel({
    required this.department,
    required this.layhaSemesters,
  });
}
final StudentHolyLaihaModel studentHolyLaiha = StudentHolyLaihaModel(
  department: "Communications and Electronics",
  layhaSemesters: [
    // ---------------- SEM 1 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Mathematics 1",
          dependentMaterials: [],
        ),
        LayhaMaterialModel(
          materialName: "Physics 1",
          dependentMaterials: [],
        ),
        LayhaMaterialModel(
          materialName: "Introduction to Programming",
          dependentMaterials: [],
        ),
        LayhaMaterialModel(
          materialName: "Engineering Drawing",
          dependentMaterials: [],
        ),
      ],
    ),

    // ---------------- SEM 2 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Mathematics 2",
          dependentMaterials: ["Mathematics 1"],
        ),
        LayhaMaterialModel(
          materialName: "Physics 2",
          dependentMaterials: ["Physics 1"],
        ),
        LayhaMaterialModel(
          materialName: "Object-Oriented Programming",
          dependentMaterials: ["Introduction to Programming"],
        ),
        LayhaMaterialModel(
          materialName: "Circuits 1",
          dependentMaterials: [],
        ),
      ],
    ),

    // ---------------- SEM 3 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Mathematics 3",
          dependentMaterials: ["Mathematics 2"],
        ),
        LayhaMaterialModel(
          materialName: "Electronics 1",
          dependentMaterials: ["Physics 2"],
        ),
        LayhaMaterialModel(
          materialName: "Circuits 2",
          dependentMaterials: ["Circuits 1"],
        ),
        LayhaMaterialModel(
          materialName: "Signals & Systems",
          dependentMaterials: ["Mathematics 2"],
        ),
      ],
    ),

    // ---------------- SEM 4 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Electronics 2",
          dependentMaterials: ["Electronics 1"],
        ),
        LayhaMaterialModel(
          materialName: "Electromagnetics 1",
          dependentMaterials: ["Physics 2", "Mathematics 3"],
        ),
        LayhaMaterialModel(
          materialName: "Digital Logic Design",
          dependentMaterials: [],
        ),
        LayhaMaterialModel(
          materialName: "Probability & Statistics",
          dependentMaterials: ["Mathematics 2"],
        ),
      ],
    ),

    // ---------------- SEM 5 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Communication Theory",
          dependentMaterials: ["Signals & Systems", "Probability & Statistics"],
        ),
        LayhaMaterialModel(
          materialName: "Electromagnetics 2",
          dependentMaterials: ["Electromagnetics 1"],
        ),
        LayhaMaterialModel(
          materialName: "Microprocessors",
          dependentMaterials: ["Digital Logic Design"],
        ),
        LayhaMaterialModel(
          materialName: "Electronics 3",
          dependentMaterials: ["Electronics 2"],
        ),
      ],
    ),

    // ---------------- SEM 6 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Digital Communications",
          dependentMaterials: ["Communication Theory"],
        ),
        LayhaMaterialModel(
          materialName: "Control Systems",
          dependentMaterials: ["Signals & Systems"],
        ),
        LayhaMaterialModel(
          materialName: "Antennas",
          dependentMaterials: ["Electromagnetics 2"],
        ),
        LayhaMaterialModel(
          materialName: "Embedded Systems",
          dependentMaterials: ["Microprocessors"],
        ),
      ],
    ),

    // ---------------- SEM 7 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Mobile Communications",
          dependentMaterials: ["Digital Communications"],
        ),
        LayhaMaterialModel(
          materialName: "Microwave Engineering",
          dependentMaterials: ["Electromagnetics 2"],
        ),
        LayhaMaterialModel(
          materialName: "Computer Networks",
          dependentMaterials: [],
        ),
        LayhaMaterialModel(
          materialName: "Digital Signal Processing",
          dependentMaterials: ["Signals & Systems"],
        ),
      ],
    ),

    // ---------------- SEM 8 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Optical Communications",
          dependentMaterials: ["Digital Communications"],
        ),
        LayhaMaterialModel(
          materialName: "RF Circuits",
          dependentMaterials: ["Microwave Engineering"],
        ),
        LayhaMaterialModel(
          materialName: "Advanced DSP",
          dependentMaterials: ["Digital Signal Processing"],
        ),
        LayhaMaterialModel(
          materialName: "Network Security",
          dependentMaterials: ["Computer Networks"],
        ),
      ],
    ),

    // ---------------- SEM 9 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "5G & Wireless Systems",
          dependentMaterials: ["Mobile Communications"],
        ),
        LayhaMaterialModel(
          materialName: "Satellite Communications",
          dependentMaterials: ["Microwave Engineering"],
        ),
        LayhaMaterialModel(
          materialName: "Fiber Optic Systems",
          dependentMaterials: ["Optical Communications"],
        ),
        LayhaMaterialModel(
          materialName: "Embedded Systems 2",
          dependentMaterials: ["Embedded Systems"],
        ),
      ],
    ),

    // ---------------- SEM 10 ----------------
    LayhaSemesterModel(
      semesterMaterials: [
        LayhaMaterialModel(
          materialName: "Graduation Project (Part 1)",
          dependentMaterials: ["5G & Wireless Systems", "Embedded Systems 2"],
        ),
        LayhaMaterialModel(
          materialName: "Advanced Network Design",
          dependentMaterials: ["Computer Networks"],
        ),
        LayhaMaterialModel(
          materialName: "Microwave Applications",
          dependentMaterials: ["RF Circuits"],
        ),
        LayhaMaterialModel(
          materialName: "Advanced Optical Networks",
          dependentMaterials: ["Fiber Optic Systems"],
        ),
      ],
    ),
  ],
);
