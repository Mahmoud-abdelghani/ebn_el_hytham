import 'dart:math';

import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/enrolled_material_student_model.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/excel_handler_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/instructor_materials_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/pdf_helper_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/pages/instructor_student_details_screen.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/bar_chart.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/bonus_section.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/export_button.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/gaussian_chart.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/section_label.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/student_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class InstructorMaterialDetailsScreen extends StatefulWidget {
  const InstructorMaterialDetailsScreen({super.key});
  static const String routeName = 'InstructorMaterialDetailsScreen';

  @override
  State<InstructorMaterialDetailsScreen> createState() =>
      _InstructorMaterialDetailsScreenState();
}

class _InstructorMaterialDetailsScreenState
    extends State<InstructorMaterialDetailsScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _bonusController = TextEditingController();
  final GlobalKey<FormState> _bonusFormKey = GlobalKey<FormState>();
  late AnimationController _chartAnimController;
  late Animation<double> _chartAnim;
  int _bonusApplied = 0;

  /// Local mutable copy of students — both grades AND chart are driven from here
  List<EnrolledMaterialStudentModel> _localStudents = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _chartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _chartAnim = CurvedAnimation(
      parent: _chartAnimController,
      curve: Curves.easeOutCubic,
    );
    _chartAnimController.forward();
  }

  @override
  void dispose() {
    _bonusController.dispose();
    _chartAnimController.dispose();
    super.dispose();
  }

  /// Called once when the cubit delivers real data — deep-copies the list.
  /// Re-initializes whenever a fresh Success state arrives (after re-fetch).
  void _initLocalStudents(List<EnrolledMaterialStudentModel> source) {
    if (_initialized) return;
    _initialized = true;
    _localStudents = source
        .map(
          (s) => EnrolledMaterialStudentModel(
            id: s.id,
            name: s.name,
            email: s.email,
            yearWork: s.yearWork,
            finalDegree: s.finalDegree,
            total: s.total,
          ),
        )
        .toList();
    _initialized = false;
  }

  /// Called after a successful re-fetch — forces a fresh deep-copy.
  void _reinitLocalStudents(List<EnrolledMaterialStudentModel> source) {
    _initialized = false;
    _bonusApplied = 0;
    _initLocalStudents(source);
  }

  /// Apply bonus: updates every student's yearWork + total in _localStudents
  void _applyBonus(int bonus) {
    setState(() {
      _bonusApplied += bonus;
      for (final s in _localStudents) {
        final newYW = (s.yearWork + bonus).clamp(0, 60);
        s.yearWork = newYW;
        s.total = (s.yearWork + s.finalDegree).clamp(0, 100);
      }
    });
    _chartAnimController
      ..reset()
      ..forward();
  }

  List<double> get _grades =>
      _localStudents.map((s) => s.total.toDouble()).toList();

  // ── Stats helpers ──────────────────────────────────────────────────────────

  double _mean(List<double> g) =>
      g.isEmpty ? 0 : g.reduce((a, b) => a + b) / g.length;

  double _std(List<double> g, double mu) {
    if (g.isEmpty) return 1;
    final variance =
        g.map((v) => (v - mu) * (v - mu)).reduce((a, b) => a + b) / g.length;
    return sqrt(variance).clamp(0.0001, double.infinity);
  }

  double _gaussian(double x, double mu, double sigma) =>
      (1 / (sigma * sqrt(2 * pi))) * exp(-pow(x - mu, 2) / (2 * pow(sigma, 2)));

  List<FlSpot> _gaussianSpots(double mu, double sigma) => [
    for (double x = 0; x <= 100; x += 0.5) FlSpot(x, _gaussian(x, mu, sigma)),
  ];

  List<BarChartGroupData> _barGroups(BuildContext context, List<double> grades) {
    final buckets = List<int>.filled(10, 0);
    for (final g in grades) {
      final idx = (g / 10).floor().clamp(0, 9);
      buckets[idx]++;
    }
    return List.generate(
      10,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: buckets[i].toDouble(),
            color: context.accent,
            width: ScreenSize.width * 0.045,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: grades.isEmpty ? 1 : grades.length.toDouble(),
              color: context.glassBorder,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int materialIndex = ModalRoute.of(context)!.settings.arguments as int;

    return BlocConsumer<InstructorMaterialsCubit, InstructorMaterialsState>(
      // Re-init local copy whenever a fresh Success comes in after update
      listenWhen: (previous, current) =>
          previous is InstructorMaterialsUpdatreLoading &&
          current is InstructorMaterialsSuccess,
      listener: (context, state) {
        if (state is InstructorMaterialsSuccess) {
          _reinitLocalStudents(
            state.materials[materialIndex].assignedMaterials,
          );
          setState(() {});
        }
      },
      builder: (context, state) {
        // ── Loading ────────────────────────────────────────────────────────
        if (state is InstructorMaterialsLoading) {
          return Scaffold(
            backgroundColor: context.scaffold,
            appBar: buildDarkAppBar(context, ''),
            body: const _DetailsShimmerLoading(),
          );
        }

        // ── Failure ────────────────────────────────────────────────────────
        if (state is InstructorMaterialsFailure) {
          return Scaffold(
            backgroundColor: context.scaffold,
            appBar: buildDarkAppBar(context, 'Error'),
            body: Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.onSurfaceMuted),
              ),
            ),
          );
        }

        if (state is! InstructorMaterialsSuccess) return const Scaffold();

        final material = state.materials[materialIndex];

        // Deep-copy once from cubit data → _localStudents drives everything
        _initLocalStudents(material.assignedMaterials);

        final grades = _grades;
        final mu = _mean(grades);
        final sigma = _std(grades, mu);
        final passCount = grades.where((g) => g >= 50).length;
        final failCount = _localStudents.length - passCount;

        return Scaffold(
          backgroundColor: context.scaffold,
          appBar: buildDarkAppBar(context, material.name),
          body: CustomScrollView(
            slivers: [
              // ── Header Info Cards ──────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.02,
                    ScreenSize.width * 0.05,
                    0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.account_balance_rounded,
                              label: 'Department',
                              value: material.departmentName,
                            ),
                          ),
                          SizedBox(width: ScreenSize.width * 0.03),
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.layers_rounded,
                              label: 'Level',
                              value: material.level,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.height * 0.012),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.location_on_rounded,
                              label: 'Location',
                              value: material.location,
                            ),
                          ),
                          SizedBox(width: ScreenSize.width * 0.03),
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.schedule_rounded,
                              label: 'Period',
                              value: material.startingPeriod,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.height * 0.012),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.calendar_month_rounded,
                              label: 'Day',
                              value: material.day,
                            ),
                          ),
                          SizedBox(width: ScreenSize.width * 0.03),
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.access_time_filled_rounded,
                              label: 'Time',
                              value: material.time,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Stats Row ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.05,
                    vertical: ScreenSize.height * 0.018,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatBadge(
                          label: 'Enrolled',
                          value: '${_localStudents.length}',
                          color: context.accent,
                          icon: Icons.group_rounded,
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.025),
                      Expanded(
                        child: _StatBadge(
                          label: 'Pass',
                          value: '$passCount',
                          color: const Color(0xFF81C784),
                          icon: Icons.check_circle_rounded,
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.025),
                      Expanded(
                        child: _StatBadge(
                          label: 'Fail',
                          value: '$failCount',
                          color: const Color(0xFFEF5350),
                          icon: Icons.cancel_rounded,
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.025),
                      Expanded(
                        child: _StatBadge(
                          label: 'Average',
                          value: mu.toStringAsFixed(1),
                          color: const Color(0xFF64B5F6),
                          icon: Icons.analytics_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bonus Section ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.05,
                  ),
                  child: BonusSection(
                    formKey: _bonusFormKey,
                    controller: _bonusController,
                    bonusApplied: _bonusApplied,
                    onApply: _applyBonus,
                    onSendToServer: () {
                      // TODO: send bonus to server
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: ScreenSize.height * 0.022),
              ),

              // ── Gaussian Chart ────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.05,
                  ),
                  child: SectionLabel(
                    label: 'Grade Distribution — Normal Curve',
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.012,
                    ScreenSize.width * 0.05,
                    0,
                  ),
                  child: AnimatedBuilder(
                    animation: _chartAnim,
                    builder: (_, __) => GaussianChart(
                      mu: mu,
                      sigma: sigma,
                      spots: _gaussianSpots(mu, sigma),
                      progress: _chartAnim.value,
                    ),
                  ),
                ),
              ),

              // ── Bar Chart ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.022,
                    ScreenSize.width * 0.05,
                    0,
                  ),
                  child: SectionLabel(label: 'Score Frequency Histogram'),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenSize.width * 0.05,
                    ScreenSize.height * 0.012,
                    ScreenSize.width * 0.05,
                    0,
                  ),
                  child: BarChartWidget(groups: _barGroups(context, grades)),
                ),
              ),

              // ── Export buttons ────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.05,
                    vertical: ScreenSize.height * 0.022,
                  ),
                  child: Row(
                    children: [
                      // ── PDF ──────────────────────────────────────────────
                      Expanded(
                        child: BlocConsumer<PdfHelperCubit, PdfHelperState>(
                          listenWhen: (_, s) =>
                              s is PdfHelperSuccess || s is PdfHelperFailure,
                          listener: (context, s) {
                            if (s is PdfHelperFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(s.message),
                                  backgroundColor: const Color(0xFFC62828),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }
                          },
                          builder: (context, s) {
                            final isLoading = s is PdfHelperLoading;
                            return _ExportLoadingButton(
                              label: 'Export PDF',
                              icon: Icons.picture_as_pdf_rounded,
                              color: const Color(0xFFEF5350),
                              isLoading: isLoading,
                              onTap: isLoading
                                  ? null
                                  : () => BlocProvider.of<PdfHelperCubit>(
                                      context,
                                    ).generateMaterialGradesReport(material),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: ScreenSize.width * 0.03),
                      // ── Excel ─────────────────────────────────────────────
                      Expanded(
                        child:
                            BlocConsumer<ExcelHandlerCubit, ExcelHandlerState>(
                              listenWhen: (_, s) =>
                                  s is ExcelHandlerSuccess ||
                                  s is ExcelHandlerFailure,
                              listener: (context, s) {
                                if (s is ExcelHandlerFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(s.message),
                                      backgroundColor: const Color(0xFFC62828),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                }
                              },
                              builder: (context, s) {
                                final isLoading = s is ExcelHandlerLoading;
                                return _ExportLoadingButton(
                                  label: 'Export Excel',
                                  icon: Icons.table_chart_rounded,
                                  color: const Color(0xFF81C784),
                                  isLoading: isLoading,
                                  onTap: isLoading
                                      ? null
                                      : () =>
                                            BlocProvider.of<ExcelHandlerCubit>(
                                              context,
                                            ).generateMaterialGradesExcel(
                                              material,
                                            ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Students List ─────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.05,
                  ),
                  child: SectionLabel(label: 'Enrolled Students'),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: ScreenSize.height * 0.012),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.05,
                ),
                sliver: SliverList.separated(
                  itemCount: _localStudents.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: ScreenSize.height * 0.01),
                  itemBuilder: (context, i) => StudentTile(
                    student: _localStudents[i],
                    index: i,
                    materialIndex: materialIndex,
                    onEdit: () {
                      Navigator.pushNamed(
                        context,
                        InstructorStudentDetailsScreen.routeName,
                        arguments: {
                          'materialIndex': materialIndex,
                          'studentIndex': i,
                        },
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: ScreenSize.height * 0.04),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Shimmer Loading ──────────────────────────────────────────────────────────

class _DetailsShimmerLoading extends StatelessWidget {
  const _DetailsShimmerLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.surface,
      highlightColor: context.accent.withOpacity(0.15),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _ShimmerBox(height: ScreenSize.height * 0.09)),
                SizedBox(width: ScreenSize.width * 0.03),
                Expanded(child: _ShimmerBox(height: ScreenSize.height * 0.09)),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.015),
            Row(
              children: [
                Expanded(child: _ShimmerBox(height: ScreenSize.height * 0.09)),
                SizedBox(width: ScreenSize.width * 0.03),
                Expanded(child: _ShimmerBox(height: ScreenSize.height * 0.09)),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.015),
            _ShimmerBox(height: ScreenSize.height * 0.06),
            SizedBox(height: ScreenSize.height * 0.015),
            _ShimmerBox(height: ScreenSize.height * 0.35),
            SizedBox(height: ScreenSize.height * 0.015),
            ...List.generate(
              4,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: ScreenSize.height * 0.012),
                child: _ShimmerBox(height: ScreenSize.height * 0.075),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  const _ShimmerBox({required this.height});

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(14),
    ),
  );
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: context.accent, size: ScreenSize.height * 0.022),
          SizedBox(width: ScreenSize.width * 0.025),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: context.textMuted,
                    fontSize: ScreenSize.height * 0.013,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: context.onBackground,
                    fontSize: ScreenSize.height * 0.016,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Badge ───────────────────────────────────────────────────────────────

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  const _StatBadge({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.014),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: ScreenSize.height * 0.022),
          SizedBox(height: ScreenSize.height * 0.005),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: ScreenSize.height * 0.022,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: context.textMuted,
              fontSize: ScreenSize.height * 0.012,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Export Loading Button ────────────────────────────────────────────────────

class _ExportLoadingButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isLoading;
  final VoidCallback? onTap;

  const _ExportLoadingButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.015),
        decoration: BoxDecoration(
          color: color.withOpacity(isLoading ? 0.06 : 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(isLoading ? 0.15 : 0.35),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: isLoading
                  ? SizedBox(
                      key: const ValueKey('spinner'),
                      width: ScreenSize.height * 0.02,
                      height: ScreenSize.height * 0.02,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    )
                  : Icon(
                      key: const ValueKey('icon'),
                      icon,
                      color: color,
                      size: ScreenSize.height * 0.022,
                    ),
            ),
            SizedBox(width: ScreenSize.width * 0.02),
            Text(
              isLoading ? 'جاري التصدير…' : label,
              style: TextStyle(
                color: color.withOpacity(isLoading ? 0.5 : 1),
                fontSize: ScreenSize.height * 0.015,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
