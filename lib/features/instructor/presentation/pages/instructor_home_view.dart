import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_materials_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_materials_list_view.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_heading.dart';
import 'package:flutter/material.dart';

class InstructorHomeView extends StatefulWidget {
  const InstructorHomeView({super.key});
  static const String routeName = 'InstructorHomeView';

  @override
  State<InstructorHomeView> createState() => _InstructorHomeViewState();
}

class _InstructorHomeViewState extends State<InstructorHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      body: Column(
        children: [
          HomeHeading(
            email: 'mohamedsalah0997@gmail.com',
            id: '21011276',
            imageUrl:
                "https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg",

            name: 'Mohamed Salah',
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
                        InstructorProfileScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/atten.png',
                    title: ' Attendance',
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/sylle.png',
                    title: 'Materials',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        InstructorMaterialsScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Group.png',
                    title: 'Today’s Lecture',
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   StudentResultsView.routeName,
                      // );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/timetable.png',
                    title: 'Time table',
                    onTap: () {
                      // Navigator.of(
                      //   context,
                      // ).pushNamed(StudentFeesView.routeName);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Salary.png',
                    title: 'Salary',
                    onTap: () {
                      // Navigator.of(
                      //   context,
                      // ).pushNamed(StudentExamsTable.routeName);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Swap.png',
                    title: 'Notifications',
                    onTap: () {
                      // Navigator.of(context).pushNamed(MilitaryView.routeName);
                    },
                  ),

                  FeatureContainer(
                    iconPath: 'assets/results.png',
                    title: 'Results',
                    onTap: () {
                      // Navigator.of(context).pushNamed(LayhaView.routename);
                    },
                  ),
                  // FeatureContainer(
                  //   iconPath: 'assets/atten.png',
                  //   title: 'التسجيل',
                  //   onTap: () {},
                  // ),
                  // FeatureContainer(
                  //   iconPath: 'assets/Support.png',
                  //   title: 'messages',
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
