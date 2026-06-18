import 'package:ebn_el_hytham/core/cubit/voice_helper_cubit.dart';
import 'package:ebn_el_hytham/core/services/voice_service.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/exams/presentation/pages/student_exams_table.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/cubit/layha_cubit.dart';
import 'package:ebn_el_hytham/features/laiha/presentation/pages/layha_view.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/assigned_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/student_materials_list_view.dart';
import 'package:ebn_el_hytham/features/profile/presentation/pages/student_profile_view.dart';
import 'package:ebn_el_hytham/features/results/presentation/cubit/results_cubit.dart';
import 'package:ebn_el_hytham/features/results/presentation/pages/student_results_view.dart';
import 'package:ebn_el_hytham/features/students/presentation/cubit/profile_cubit.dart';
import 'package:ebn_el_hytham/features/students/presentation/pages/settings.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_grid_shimmer.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/home_heading.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/student_banner_card.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/student_square_card.dart';
import 'package:ebn_el_hytham/features/students/presentation/widgets/student_wide_card.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/pages/student_schedule_view%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Voice matchers ────────────────────────────────────────────────────────────
bool _voiceSaysProfile(String lower) =>
    lower.contains('prooofiiiile') ||
    lower.contains('بروفايل') ||
    lower.contains('profile') ||
    lower.contains('البروفايل');

bool _voiceSaysMaterials(String lower) => lower.contains('material');
bool _voiceSaysResults(String lower) => lower.contains('result');

class StudentHomeView extends StatefulWidget {
  const StudentHomeView({super.key});
  static const String routeName = 'StudentHomeView';

  @override
  State<StudentHomeView> createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
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
            const HomeHeading(),
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading || state is ProfileInitial) {
                    return const HomeGridShimmer();
                  }
                  if (state is ProfileError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  }
                  if (state is! ProfileSuccess) {
                    return const HomeGridShimmer();
                  }
                  return _StudentFeatureGrid(profile: state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════
//  FEATURE GRID
// ════════════════════════════════════════════════════════
class _StudentFeatureGrid extends StatelessWidget {
  final ProfileSuccess profile;
  const _StudentFeatureGrid({required this.profile});

  @override
  Widget build(BuildContext context) {
    final p = ScreenSize.width * 0.04;
    final gap = ScreenSize.width * 0.03;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(p, p * 0.8, p, p),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section label ─────────────────────────────────────
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: ColorGuid.amber,
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
          SizedBox(height: ScreenSize.height * 0.018),

          // ══ ROW 1 — Materials + Timetable (featured) ══════════
          Row(
            children: [
              Expanded(
                child: StudentWideCard(
                  iconPath: 'assets/Group.png',
                  title: 'Materials',
                  subtitle: 'Courses & content',
                  accentColor: const Color(0xFF4E6AF3),
                  onTap: () {
                    context
                        .read<AssignedMaterialsCubit>()
                        .fetchAssignedMaterials(studentId: profile.profile.id);
                    Navigator.pushNamed(
                      context,
                      StudentMaterialsListView.routeName,
                    );
                  },
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: StudentWideCard(
                  iconPath: 'assets/timetable.png',
                  title: 'Timetable',
                  subtitle: 'Weekly schedule',
                  accentColor: const Color(0xFF2ECC71),
                  onTap: () {
                    context
                        .read<AssignedMaterialsCubit>()
                        .fetchAssignedMaterials(studentId: profile.profile.id);
                    Navigator.pushNamed(context, StudentScheduleView.routeName);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: gap),

          // ══ ROW 2 — Results + Exams + اللائحة ═════════════════
          Row(
            children: [
              Expanded(
                child: StudentSquareCard(
                  iconPath: 'assets/results.png',
                  title: 'Results',
                  onTap: () {
                    context.read<ResultsCubit>().fetchResultOfStudent(
                      studentId: profile.profile.id,
                    );
                    Navigator.pushNamed(context, StudentResultsView.routeName);
                  },
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: StudentSquareCard(
                  iconPath: 'assets/Exam.png',
                  title: 'Exams',
                  onTap: () =>
                      Navigator.pushNamed(context, StudentExamsTable.routeName),
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: StudentSquareCard(
                  iconPath: 'assets/sylle.png',
                  title: 'اللائحة',
                  onTap: () {
                    context.read<LayhaCubit>().fetchLayha(
                      department: profile.profile.department,
                      id: profile.profile.id,
                    );
                    Navigator.pushNamed(context, LayhaView.routename);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: gap),

          // ══ ROW 3 — التسجيل (Banner) ══════════════════════════
          StudentBannerCard(
            iconPath: 'assets/atten.png',
            title: 'Course Registration',
            subtitle: 'Enroll in your semester courses',
            accentColor: const Color(0xFFE67E22),
            onTap: () {},
          ),
          SizedBox(height: gap),

          // ══ ROW 4 — Profile + الاعدادات ══════════════════════
          Row(
            children: [
              Expanded(
                child: StudentSquareCard(
                  iconPath: 'assets/Faculties.png',
                  title: 'Profile',
                  onTap: () => Navigator.pushNamed(
                    context,
                    StudentProfileView.routeName,
                  ),
                ),
              ),
              SizedBox(width: gap),
              Expanded(
                child: StudentSquareCard(
                  iconPath: 'assets/Image_20260412_214317.png',
                  title: 'Settings',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      StudentSettingsScreen.routeName,
                      arguments: profile.profile,
                    );
                  },
                ),
              ),
              SizedBox(width: gap),
              // spacer للـ symmetry
              Expanded(child: const SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}
