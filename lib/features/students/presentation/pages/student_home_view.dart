import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/exams/presentation/pages/student_exams_table.dart';
import 'package:ebn_el_hytham/features/fees/presentation/pages/student_fees_view.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/cubit/layha_cubit.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/pages/layha_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/assigned_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_materials_list_view.dart';
import 'package:ebn_el_hytham/features/military/presentation/pages/military_view.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/student_profile_view.dart';
import 'package:ebn_el_hytham/features/results/presentation/cubit/results_cubit.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/student_results_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/cubit/profile_cubit.dart';
import 'package:ebn_el_hytham/features/students/presentation/pages/settings.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/feature_container.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_grid_shimmer.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_heading.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/time_table_model.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/instructor_timetable_screen.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/student_schedule_view%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentHomeView extends StatefulWidget {
  const StudentHomeView({super.key});
  static const String routeName = "StudentHomeView";

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

// ── Voice matchers ────────────────────────────────────────────────────────
bool _voiceSaysProfile(String lower) =>
    lower.contains('prooofiiiile') ||
    lower.contains('بروفايل') ||
    lower.contains('profile') ||
    lower.contains('البروفايل');

bool _voiceSaysMaterials(String lower) => lower.contains('material');
bool _voiceSaysResults(String lower) => lower.contains('result');

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceHelperCubit, String>(
      listener: (context, state) async {
        final cubit = context.read<VoiceHelperCubit>();
        if (!cubit.isStudentSession || !cubit.isOn) return;
        if (state == 'Off' || state.trim().isEmpty) return;

        final lower = state.toLowerCase().trim();

        if (_voiceSaysProfile(lower)) {
          await cubit.stop();
          if (!context.mounted) return;
          await Navigator.pushNamed(
            context,
            StudentProfileView.routeName,
            arguments: StudentProfileView.readScreenAloud,
          );
          if (!context.mounted) return;
          if (cubit.isStudentSession) await cubit.start();
        } else if (_voiceSaysMaterials(lower)) {
          await VoiceService.speak('Materials');
          if (!context.mounted) return;
          Navigator.pushNamed(context, StudentMaterialsListView.routeName);
        } else if (_voiceSaysResults(lower)) {
          await VoiceService.speak('Results');
          if (!context.mounted) return;
          Navigator.pushNamed(context, StudentResultsView.routeName);
        }
      },
      child: Scaffold(
        backgroundColor: ColorGuid.scaffoldBackgroundColor,
        body: Column(
          children: [
            // ── Header handles its own shimmer internally ─────────
            const HomeHeading(),

            // ── Grid — shimmer on loading, real on success/error ──
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading || state is ProfileInitial) {
                    return const HomeGridShimmer();
                  } else if (state is ProfileError) {
                    return Center(child: Text(state.message));
                  } else if (state is! ProfileSuccess) {
                    return Center(child: Text(state.toString()));
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.0486,
                    ),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                      children: [
                        FeatureContainer(
                          iconPath: 'assets/Faculties.png',
                          title: 'Profile',
                          onTap: () => Navigator.pushNamed(
                            context,
                            StudentProfileView.routeName,
                          ),
                        ),
                        FeatureContainer(
                          iconPath: 'assets/Group.png',
                          title: 'Materials',
                          onTap: () {
                            context
                                .read<AssignedMaterialsCubit>()
                                .fetchAssignedMaterials(
                                  studentId: state.profile.id,
                                );
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
                            context
                                .read<AssignedMaterialsCubit>()
                                .fetchAssignedMaterials(
                                  studentId: state.profile.id,
                                );
                            Navigator.pushNamed(
                              context,
                              StudentScheduleView.routeName,
                            );
                          },
                        ),
                        FeatureContainer(
                          iconPath: 'assets/results.png',
                          title: 'Results',
                          onTap: () {
                            context.read<ResultsCubit>().fetchResultOfStudent(
                              studentId: state.profile.id,
                            );
                            Navigator.pushNamed(
                              context,
                              StudentResultsView.routeName,
                            );
                          },
                        ),
                        FeatureContainer(
                          iconPath: 'assets/Fee.png',
                          title: 'Fees',
                          onTap: () => Navigator.pushNamed(
                            context,
                            StudentFeesView.routeName,
                          ),
                        ),
                        FeatureContainer(
                          iconPath: 'assets/Exam.png',
                          title: 'Exams',
                          onTap: () => Navigator.pushNamed(
                            context,
                            StudentExamsTable.routeName,
                          ),
                        ),
                        FeatureContainer(
                          iconPath: 'assets/Icard.png',
                          title: 'العسكرية',
                          onTap: () => Navigator.pushNamed(
                            context,
                            MilitaryView.routeName,
                          ),
                        ),
                        FeatureContainer(
                          iconPath: 'assets/sylle.png',
                          title: 'الايحه',
                          onTap: () {
                            BlocProvider.of<LayhaCubit>(context).fetchLayha(
                              department: state.profile.department,
                              id: state.profile.id,
                            );
                            Navigator.pushNamed(context, LayhaView.routename);
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
                        FeatureContainer(
                          iconPath: 'assets/Image_20260412_214317.png',
                          title: 'الاعدادات',
                          onTap: () =>
                              Navigator.pushNamed(context, Settings.routeName),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
