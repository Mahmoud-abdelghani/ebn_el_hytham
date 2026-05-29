import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/results/presentation/cubit/results_cubit.dart';
import 'package:ebn_el_hytham/features/results/presentation/widgets/custom_semester_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentResultsView extends StatefulWidget {
  const StudentResultsView({super.key});
  static const String routeName = 'StudentResultsView';

  @override
  State<StudentResultsView> createState() => _StudentResultsViewState();
}

class _StudentResultsViewState extends State<StudentResultsView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerCtrl;
  late final Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _shimmerAnim = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  // ── Shimmer box ──────────────────────────────────────────────────────
  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return AnimatedBuilder(
      animation: _shimmerAnim,
      builder: (_, __) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            begin: Alignment(_shimmerAnim.value - 1, 0),
            end: Alignment(_shimmerAnim.value + 1, 0),
            colors: [
              ColorGuid.surfaceColor,
              ColorGuid.surfaceColor.withOpacity(0.5),
              ColorGuid.amber.withOpacity(0.07),
              ColorGuid.surfaceColor.withOpacity(0.5),
              ColorGuid.surfaceColor,
            ],
          ),
        ),
      ),
    );
  }

  // ── Shimmer semester card ─────────────────────────────────────────────
  Widget _shimmerCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorGuid.glassBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _shimmerBox(
            width: ScreenSize.width * 0.32,
            height: ScreenSize.height * 0.02,
          ),
          _shimmerBox(
            width: ScreenSize.width * 0.16,
            height: ScreenSize.height * 0.02,
            radius: 5,
          ),
        ],
      ),
    );
  }

  // ── Full shimmer layout ───────────────────────────────────────────────
  Widget _buildShimmer() {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        // GPA banner shimmer
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.04,
              vertical: ScreenSize.height * 0.015,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.05,
              vertical: ScreenSize.height * 0.022,
            ),
            decoration: BoxDecoration(
              color: ColorGuid.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorGuid.amber.withOpacity(0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _shimmerBox(
                  width: ScreenSize.width * 0.28,
                  height: ScreenSize.height * 0.024,
                ),
                _shimmerBox(
                  width: ScreenSize.width * 0.15,
                  height: ScreenSize.height * 0.028,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(height: ScreenSize.height * 0.01)),
        SliverList.separated(
          separatorBuilder: (_, __) =>
              SizedBox(height: ScreenSize.height * 0.012),
          itemBuilder: (_, __) => _shimmerCard(),
          itemCount: 4,
        ),
      ],
    );
  }

  // ── GPA banner ────────────────────────────────────────────────────────
  Widget _buildGpaBanner(String gpa) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.04,
        vertical: ScreenSize.height * 0.015,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorGuid.amber.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: ColorGuid.amber.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label + subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CUMULATIVE GPA',
                style: TextStyle(
                  color: ColorGuid.textSecondary,
                  fontSize: ScreenSize.height * 0.014,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: ScreenSize.height * 0.004),
              Text(
                'Academic Standing',
                style: TextStyle(
                  color: ColorGuid.textSecondary.withOpacity(0.5),
                  fontSize: ScreenSize.height * 0.013,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // GPA value
          Text(
            gpa,
            style: TextStyle(
              color: ColorGuid.amber,
              fontWeight: FontWeight.w800,
              fontSize: ScreenSize.height * 0.038,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Results'),
      body: BlocBuilder<ResultsCubit, ResultsState>(
        builder: (context, state) {
          if (state is ResultsLoading || state is ResultsInitial) {
            return _buildShimmer();
          }

          if (state is ResultsError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline,
                      color: ColorGuid.amber, size: 44),
                  SizedBox(height: ScreenSize.height * 0.015),
                  Text(
                    state.message,
                    style: TextStyle(
                      color: ColorGuid.textSecondary,
                      fontSize: ScreenSize.height * 0.018,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is! ResultsSuccess) {
            return Center(
              child: Text(
                'Unexpected error occurred.',
                style: TextStyle(color: ColorGuid.textSecondary),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // GPA banner
              SliverToBoxAdapter(
                child: _buildGpaBanner(
                  state.model.cgba.toStringAsFixed(2),
                ),
              ),

              SliverToBoxAdapter(
                  child: SizedBox(height: ScreenSize.height * 0.008)),

              // Section label
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.055,
                    vertical: ScreenSize.height * 0.008,
                  ),
                  child: Text(
                    'SEMESTER RESULTS',
                    style: TextStyle(
                      color: ColorGuid.textSecondary.withOpacity(0.6),
                      fontSize: ScreenSize.height * 0.013,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ),

              // Semester cards
              SliverList.separated(
                separatorBuilder: (_, __) =>
                    SizedBox(height: ScreenSize.height * 0.012),
                itemBuilder: (context, index) {
                  final semester = state.model.listOfSemesters[index];

                  final List<String> readyList = ['Subject', 'Code', 'Grade'];
                  for (final m in semester.listOfMaterials) {
                    readyList.addAll([m.corseName, m.corseCode, m.grade]);
                  }

                  final gpa =
                      state.model.listOfSemesterGpas.length > index
                          ? state.model.listOfSemesterGpas[index]
                              .toStringAsFixed(2)
                          : 'N/A';

                  return CustomSemesterWidget(
                    elements: readyList,
                    index: index + 1,
                    gpa: gpa,
                  );
                },
                itemCount: state.model.listOfSemesters.length,
              ),

              SliverToBoxAdapter(
                  child: SizedBox(height: ScreenSize.height * 0.03)),
            ],
          );
        },
      ),
    );
  }
}