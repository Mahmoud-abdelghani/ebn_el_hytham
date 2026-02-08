import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/exams/presentation/pages/student_exams_table.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/student_fees_view.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/pages/layha_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_materials_list_view.dart';
import 'package:ebn_el_hytham/features/military/presentation/pages/military_view.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/student_profile_view.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/student_results_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_heading.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/time_table_model.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:flutter/material.dart';

class StudentHomeView extends StatefulWidget {
  const StudentHomeView({super.key});
  static const String routeName = "StudentHomeView";

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      body: Column(
        children: [
          HomeHeading(
            email: 'mahmoudabdelghani0997@gmail.com',
            id: '21011276',
            imageUrl:
                "https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg",

            name: 'Mahmoud Abdelghany',
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.0486111111121238,
              ),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [
                  FeatureContainer(
                    iconPath: 'assets/Faculties.png',
                    title: 'Profile',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StudentProfileView.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Group.png',
                    title: 'Materials',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StudentMaterialsListView.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/timetable.png',
                    title: 'Time table',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        InstructorTimetableScreen.routeName,
                        arguments: timeTableDataStudent
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/results.png',
                    title: 'Results',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StudentResultsView.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Fee.png',
                    title: 'Fees',
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(StudentFeesView.routeName);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Exam.png',
                    title: 'Exams',
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(StudentExamsTable.routeName);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Icard.png',
                    title: 'العسكرية',
                    onTap: () {
                      Navigator.of(context).pushNamed(MilitaryView.routeName);
                    },
                  ),

                  FeatureContainer(
                    iconPath: 'assets/sylle.png',
                    title: 'الايحه',
                    onTap: () {
                      Navigator.of(context).pushNamed(LayhaView.routename);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/atten.png',
                    title: 'التسجيل',
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Support.png',
                    title: 'messages',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//height = 914.2857142857143
//width =  411.42857142857144
