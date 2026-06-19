// lib/features/timetable/presentation/pages/instructor_schedule_view.dart

import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/timetable/data/models/instructor_materia_table_model.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/cubit/instructor_timetable_cubit.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/widgets/schedule_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorTimetableScreen extends StatelessWidget {
  const InstructorTimetableScreen ({super.key});
  static const String routeName = 'InstructorScheduleView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffold,
      appBar: buildDarkAppBar(context, 'My Schedule'),
      body: BlocBuilder<InstructorTimetableCubit, InstructorTimetableState>(
        builder: (context, state) {
          if (state is InstructorTimetableLoading ||
              state is InstructorTimetableInitial) {
            return const ScheduleShimmerLoading();
          } else if (state is InstructorTimetableError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.onSurfaceMuted),
              ),
            );
          } else if (state is! InstructorTimetableSuccess) {
            return const ScheduleShimmerLoading();
          }

          return InstructorScheduleGrid(materials: state.assignedCourses);
        },
      ),
    );
  }
}

// ── Schedule Grid ─────────────────────────────────────────────────────────────
class InstructorScheduleGrid extends StatelessWidget {
  final List<InstructorMateriaTableModel> materials;

  const InstructorScheduleGrid({super.key, required this.materials});

  static const List<String> _days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  static const List<String> _periodTimes = [
    '08:30',
    '10:00',
    '11:40',
    '01:10',
    '02:40',
    '04:10',
  ];

  static const int _periodsCount = 6;

  static const List<Color> _courseColors = [
    Color(0xFF4E6AF3),
    Color(0xFF2ECC71),
    Color(0xFFE74C3C),
    Color(0xFF9B59B6),
    Color(0xFFE67E22),
    Color(0xFF1ABC9C),
    Color(0xFFE91E8C),
  ];

  @override
  Widget build(BuildContext context) {
    // map: courseCode → color  (أوضح من الاسم الطويل)
    final colorMap = <String, Color>{};
    for (int i = 0; i < materials.length; i++) {
      colorMap[materials[i].courseCode] =
          _courseColors[i % _courseColors.length];
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(ScreenSize.width * 0.03),
      child: Column(
        children: [
          // ── Legend ───────────────────────────────────────────
          _InstructorLegend(materials: materials, colorMap: colorMap),
          SizedBox(height: ScreenSize.height * 0.018),

          // ── Grid ─────────────────────────────────────────────
          _buildGrid(context, colorMap),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, Map<String, Color> colorMap) {
    // lookup key: "Day_periodNumber"  e.g. "Saturday_1"
    final lookup = <String, InstructorMateriaTableModel>{};
    for (final m in materials) {
      final key = '${m.day}_${m.startingPeriod}';
      lookup[key] = m;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: 55 + (6 * 100.0),
        child: Table(
          border: TableBorder.all(color: context.cardBorder, width: 0.8),
          columnWidths: const {
            0: FixedColumnWidth(55),
            1: FixedColumnWidth(100),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(100),
            5: FixedColumnWidth(100),
            6: FixedColumnWidth(100),
          },
          children: [
            // ── Header row ──────────────────────────────────────
            TableRow(
              decoration: BoxDecoration(color: context.surface),
              children: [
                _HeaderCell(text: ''),
                ..._days.map((d) => _HeaderCell(text: _shortDay(d))),
              ],
            ),
            // ── Period rows ─────────────────────────────────────
            ...List.generate(_periodsCount, (periodIndex) {
              final periodNumber = periodIndex + 1;
              return TableRow(
                children: [
                  _PeriodCell(
                    period: periodNumber,
                    time: _periodTimes[periodIndex],
                  ),
                  ..._days.map((day) {
                    final key = '${day}_$periodNumber';
                    final material = lookup[key];
                    if (material != null) {
                      return _InstructorCourseCell(
                        material: material,
                        color: colorMap[material.courseCode]!,
                      );
                    }
                    return const _EmptyCell();
                  }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  static String _shortDay(String day) {
    const map = {
      'Saturday': 'Sat',
      'Sunday': 'Sun',
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
    };
    return map[day] ?? day.substring(0, 3);
  }
}

// ── Legend ────────────────────────────────────────────────────────────────────
class _InstructorLegend extends StatelessWidget {
  final List<InstructorMateriaTableModel> materials;
  final Map<String, Color> colorMap;

  const _InstructorLegend({required this.materials, required this.colorMap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize.width * 0.04),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.cardBorder),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: materials.map((m) {
          final color = colorMap[m.courseCode]!;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 5),
              // كود المادة + اسمها
              Text(
                '${m.courseCode} · ${m.courseName}',
                style: TextStyle(
                  color: context.onSurfaceMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ── Header Cell ───────────────────────────────────────────────────────────────
class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.accent,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Period Cell ───────────────────────────────────────────────────────────────
class _PeriodCell extends StatelessWidget {
  final int period;
  final String time;
  const _PeriodCell({required this.period, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      color: context.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'P$period',
            style: TextStyle(
              color: context.accent,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(color: context.textMuted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

// ── Course Cell (instructor-specific: يعرض location + course code) ────────────
class _InstructorCourseCell extends StatelessWidget {
  final InstructorMateriaTableModel material;
  final Color color;
  const _InstructorCourseCell({required this.material, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.7), width: 1.2),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course code badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              material.courseCode,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 3),
          // Course name
          Text(
            material.courseName,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          // Location
          Row(
            children: [
              Icon(Icons.location_on, color: context.textMuted, size: 9),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  material.lectureLocation,
                  style: TextStyle(color: context.onSurfaceMuted, fontSize: 9),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Empty Cell ────────────────────────────────────────────────────────────────
class _EmptyCell extends StatelessWidget {
  const _EmptyCell();

  @override
  Widget build(BuildContext context) {
    return Container(height: 80, color: Colors.transparent);
  }
}
