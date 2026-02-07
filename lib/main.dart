import 'package:ebn_el_hytham/features/authentication/presentation/pages/login_view.dart';
import 'package:ebn_el_hytham/features/exams/presentation/pages/student_exams_table.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/instructor_salary_screen.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/student_fees_view.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/image_processing_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/pages/instructor_home_view.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/pages/layha_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_material_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_materials_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_student_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_material_details_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_materials_list_view.dart';
import 'package:ebn_el_hytham/features/military/presentation/pages/military_view.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/student_profile_view.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_details_result_screen.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_result_screen.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/student_results_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/pages/student_home_view.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ImageProcessingCubit())],

      child: MaterialApp(
        routes: {
          LoginView.routeName: (context) => LoginView(),
          StudentHomeView.routeName: (context) => StudentHomeView(),
          InstructorHomeView.routeName: (context) => InstructorHomeView(),
          StudentProfileView.routeName: (context) => StudentProfileView(),
          StudentMaterialsListView.routeName: (context) =>
              StudentMaterialsListView(),
          StudentMaterialDetailsView.routeName: (context) =>
              StudentMaterialDetailsView(),
          StudentResultsView.routeName: (context) => StudentResultsView(),
          StudentFeesView.routeName: (context) => StudentFeesView(),
          StudentExamsTable.routeName: (context) => StudentExamsTable(),
          MilitaryView.routeName: (context) => MilitaryView(),
          LayhaView.routename: (context) => LayhaView(),
          InstructorMaterialsScreen.routeName: (context) =>
              InstructorMaterialsScreen(),
          InstructorProfileScreen.routeName: (context) =>
              InstructorProfileScreen(),
          InstructorMaterialDetailsScreen.routeName: (context) =>
              InstructorMaterialDetailsScreen(),
          InstructorStudentDetailsScreen.routeName: (context) =>
              InstructorStudentDetailsScreen(),
          InstructorTimetableScreen.routeName: (context) =>
              InstructorTimetableScreen(),
          InstructorSalaryScreen.routeName: (context) =>
              InstructorSalaryScreen(),
          InstructorResultScreen.routeName: (context) =>
              InstructorResultScreen(),
          InstructorDetailsResultScreen.routeName: (context) =>
              InstructorDetailsResultScreen(),
        },
        initialRoute: LoginView.routeName,
      ),
    );
  }
}
