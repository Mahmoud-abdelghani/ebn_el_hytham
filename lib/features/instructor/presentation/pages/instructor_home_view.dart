import 'package:ebn_el_hytham/features/fees/presentation/pages/instructor_salary_screen.dart';
import 'package:ebn_el_hytham/features/instructor/data/models/instructor_model.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/custom_alert_dialog.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/success_header.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/instructor_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_materials_screen.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/instructor_profile_screen.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/instructor_result_screen.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/cubit/instructor_timetable_cubit.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/instructor_profile_cubit.dart';
// ... باقى الـ imports

class InstructorHomeView extends StatefulWidget {
  const InstructorHomeView({super.key});
  static const String routeName = 'InstructorHomeView';

  @override
  State<InstructorHomeView> createState() => _InstructorHomeViewState();
}

class _InstructorHomeViewState extends State<InstructorHomeView> {
  static const Color _bgDark = Color(0xFF161B22);
  static const Color _bgCard = Color(0xFF1F2630);
  static const Color _amber = Color(0xFFFFC94A);
  InstructorModel? _profile;

  @override
  void initState() {
    super.initState();
    // اعمل fetch هنا لو مش بتعملها من قبل
    // context.read<InstructorProfileCubit>().getProfileData(token: '...');
  }

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    ScreenSize.init(context);
    return Scaffold(
      backgroundColor: _bgDark,
      body: Column(
        children: [
          // ── Header مع BlocBuilder ──
          BlocBuilder<InstructorProfileCubit, InstructorProfileState>(
            builder: (context, state) {
              if (state is InstructorProfileLoading ||
                  state is InstructorProfileInitial) {
                return ShimmerHeader(bgCard: _bgCard, amber: _amber);
              }

              if (state is InstructorProfileError) {
                return ErrorHeader(
                  bgCard: _bgCard,
                  amber: _amber,
                  message: state.message,
                  onRetry: () {
                    context.read<InstructorProfileCubit>().getProfileData(
                      token: id,
                    );
                  },
                );
              }

              if (state is InstructorProfileSuccess) {
                final profile = state.profile;
                _profile = profile;
                return SuccessHeader(
                  bgCard: _bgCard,
                  amber: _amber,
                  profile: profile,
                );
              }

              return const SizedBox();
            },
          ),

          // ── Section Label ──
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.width * 0.05,
              right: ScreenSize.width * 0.05,
              top: ScreenSize.height * 0.025,
              bottom: ScreenSize.height * 0.008,
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: _amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Quick Access',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: ScreenSize.height * 0.018,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),

          // ── Feature Grid ──
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
              ),
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [
                  FeatureContainer(
                    iconPath: 'assets/Faculties.png',
                    title: 'Profile',
                    onTap: () => Navigator.pushNamed(
                      context,
                      InstructorProfileScreen.routeName,
                      arguments: id,
                    ),
                  ),
                  FeatureContainer(
                    iconPath: 'assets/atten.png',
                    title: 'Attendance',
                    onTap: () {
                      if (_profile == null) return;
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          assignedMaterials: _profile!.assignedMaterials,
                        ),
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/sylle.png',
                    title: 'Materials',
                    onTap: () {
                      if (_profile == null) return;
                      BlocProvider.of<InstructorMaterialsCubit>(
                        context,
                      ).fetchInstructorMaterials(instructorId: _profile!.id);
                      Navigator.pushNamed(
                        context,
                        InstructorMaterialsScreen.routeName,
                      );
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Group.png',
                    title: "Today's Lecture",
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/timetable.png',
                    title: 'Time Table',
                    onTap: () {
                      BlocProvider.of<InstructorTimetableCubit>(
                        context,
                      ).fetchTable(id: id);
                      Navigator.of(
                        context,
                      ).pushNamed(InstructorTimetableScreen.routeName);
                    },
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Salary.png',
                    title: 'Salary',
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(InstructorSalaryScreen.routeName),
                  ),
                  FeatureContainer(
                    iconPath: 'assets/Swap.png',
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  FeatureContainer(
                    iconPath: 'assets/results.png',
                    title: 'Results',
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(InstructorResultScreen.routeName),
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
