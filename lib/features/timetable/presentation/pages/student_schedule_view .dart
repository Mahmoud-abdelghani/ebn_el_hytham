// lib/features/materials/presentation/pages/student_schedule_view.dart

import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/assigned_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/assigned_materials_cubit.dart';
import 'package:ebn_el_hytham/features/timetable/presentation/widgets/schedule_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentScheduleView extends StatelessWidget {
  const StudentScheduleView({super.key});
  static const String routeName = 'StudentScheduleView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffold,
      appBar: buildDarkAppBar(context, 'Weekly Schedule'),
      body: BlocBuilder<AssignedMaterialsCubit, AssignedMaterialsState>(
        builder: (context, state) {
          if (state is AssignedMaterialsLoading) {
            return const ScheduleShimmerLoading();
          } else if (state is AssignedMaterialsFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: context.onSurfaceMuted),
              ),
            );
          } else if (state is! AssignedMaterialsSuccess) {
            return const ScheduleShimmerLoading();
          }

          final scheduled = state.materials
              .where(
                (m) =>
                    m.day != 'No data yet' && m.startingPeriod != 'No data yet',
              )
              .toList();

          return ScheduleGrid(materials: scheduled);
        },
      ),
    );
  }
}

// ── Schedule Grid ─────────────────────────────────────────────────────────────
class ScheduleGrid extends StatelessWidget {
  final List<AssignedMaterialModel> materials;

  const ScheduleGrid({super.key, required this.materials});

  // أيام الأسبوع بالترتيب
  static const List<String> _days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];

  // أوقات كل فترة
  static const List<String> _periodTimes = [
    '08:30',
    '10:00',
    '11:40',
    '01:10',
    '02:40',
    '04:10',
  ];

  static const int _periodsCount = 6;

  // لون لكل مادة بناءً على الـ index
  static const List<Color> _courseColors = [
    Color(0xFF4E6AF3), // blue
    Color(0xFF2ECC71), // green
    Color(0xFFE74C3C), // red
    Color(0xFF9B59B6), // purple
    Color(0xFFE67E22), // orange
    Color(0xFF1ABC9C), // teal
    Color(0xFFE91E8C), // pink
  ];

  @override
  Widget build(BuildContext context) {
    // map: courseName → color
    final colorMap = <String, Color>{};
    for (int i = 0; i < materials.length; i++) {
      colorMap[materials[i].name] = _courseColors[i % _courseColors.length];
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(ScreenSize.width * 0.03),
      child: Column(
        children: [
          // ── Legend ───────────────────────────────────────────
          _Legend(materials: materials, colorMap: colorMap),
          SizedBox(height: ScreenSize.height * 0.018),

          // ── Grid ─────────────────────────────────────────────
          _buildGrid(context, colorMap),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, Map<String, Color> colorMap) {
    final lookup = <String, AssignedMaterialModel>{};
    for (final m in materials) {
      final from = int.tryParse(m.startingPeriod) ?? 0;
      final key = '${m.day}_$from';
      lookup[key] = m;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        width: 55 + (6 * 100.0), // عمود الفترات + 6 أيام
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
            TableRow(
              decoration: BoxDecoration(color: context.surface),
              children: [
                _HeaderCell(text: ''),
                ..._days.map((d) => _HeaderCell(text: _shortDay(d))),
              ],
            ),
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
                      return _CourseCell(
                        material: material,
                        color: colorMap[material.name]!,
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
class _Legend extends StatelessWidget {
  final List<AssignedMaterialModel> materials;
  final Map<String, Color> colorMap;

  const _Legend({required this.materials, required this.colorMap});

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
          final color = colorMap[m.name]!;
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
              Text(
                m.name,
                style: TextStyle(
                  color: context.onSurfaceMuted,
                  fontSize: 16,
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

// ── Table Cells ───────────────────────────────────────────────────────────────

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
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _PeriodCell extends StatelessWidget {
  final int period;
  final String time;
  const _PeriodCell({required this.period, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      color: context.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'P$period',
            style: TextStyle(
              color: context.accent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: TextStyle(color: context.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _CourseCell extends StatelessWidget {
  final AssignedMaterialModel material;
  final Color color;
  const _CourseCell({required this.material, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.7), width: 1.2),
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اسم المادة (مختصر)
          Text(
            material.name,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          // الموقع
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

          // الوقت
        ],
      ),
    );
  }
}

class _EmptyCell extends StatelessWidget {
  const _EmptyCell();

  @override
  Widget build(BuildContext context) {
    return Container(height: 72, color: Colors.transparent);
  }
}
