import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:ebn_el_hytham/features/authentication/presentation/pages/login_view.dart';
import 'package:ebn_el_hytham/features/exams/presentation/pages/student_exams_table.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/instructor_salary_screen.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/student_fees_view.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/attendance_cubit.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://gbgbgrtfcmcoggvjbmrx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdiZ2JncnRmY21jb2dndmpibXJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzEwOTkwMzYsImV4cCI6MjA4NjY3NTAzNn0.MKOTWFaDuopE25-tVZMoAJaFiVfKM1-CauPBbWI89Pk',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageProcessingCubit()),
        BlocProvider(create: (context) => AttendanceCubit()),
        BlocProvider(create: (context) => VoiceHelperCubit(VoiceService()),)
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        /// Global dark theme — ensures all default Flutter widgets adopt
        /// the dark charcoal + amber accent design spirit
        theme: ThemeData(
          brightness: Brightness.dark,
          // [scaffoldBackgroundColor] — deep charcoal as global page bg
          scaffoldBackgroundColor: const Color(0xFF161B22),
          // [surfaceColor] — dark card as global card/canvas bg
          cardColor: const Color(0xFF1F2630),
          // [amber] as the primary swatch across the app
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFFC94A),
            secondary: Color(0xFFFFC94A),
            surface: Color(0xFF1F2630),
            onSurface: Color(0xFFFFFFFF),
            onPrimary: Color(0xFF161B22),
          ),
          // Dark AppBar by default
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1F2630),
            foregroundColor: Color(0xFFFFFFFF),
            elevation: 0,
          ),
          // Icon color defaults to amber
          iconTheme: const IconThemeData(color: Color(0xFFFFC94A)),
          // Typography — white text on dark
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFFFFFFFF)),
            bodyMedium: TextStyle(color: Color(0xFFB0BAC8)),
          ),
          // FAB amber
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFFFC94A),
            foregroundColor: Color(0xFF161B22),
          ),
          // Dialog dark
          dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF1F2630)),
        ),
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
