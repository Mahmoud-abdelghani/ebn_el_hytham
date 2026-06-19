import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/assigned_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/email_handler_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentMaterialDetailsView extends StatelessWidget {
  const StudentMaterialDetailsView({super.key});
  static const String routeName = 'StudentMaterialDetailsView';

  @override
  Widget build(BuildContext context) {
    final model =
        ModalRoute.of(context)!.settings.arguments as AssignedMaterialModel;

    return Scaffold(
      backgroundColor: context.scaffold,
      appBar: buildDarkAppBar(context, model.name),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.05,
          vertical: ScreenSize.height * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderCard(model: model),
            SizedBox(height: ScreenSize.height * 0.018),
            _SectionTitle(
              title: 'Schedule',
              icon: Icons.calendar_today_rounded,
            ),
            SizedBox(height: ScreenSize.height * 0.010),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Day',
                  value: model.day,
                ),
                _InfoRow(
                  icon: Icons.access_time_rounded,
                  label: 'Time',
                  value: model.lectureTime,
                ),
                _InfoRow(
                  icon: Icons.looks_one_outlined,
                  label: 'Period',
                  value: model.startingPeriod,
                ),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: model.lectureLocation,
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.018),
            _SectionTitle(
              title: 'Instructor',
              icon: Icons.person_outline_rounded,
            ),
            SizedBox(height: ScreenSize.height * 0.010),
            _InfoCard(
              children: [
                _InfoRow(
                  icon: Icons.badge_outlined,
                  label: 'Name',
                  value: model.instructorName,
                ),
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: model.instructorEmail,
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.018),
            _SectionTitle(title: 'Results', icon: Icons.bar_chart_rounded),
            SizedBox(height: ScreenSize.height * 0.010),
            _ResultsCard(model: model),
            SizedBox(height: ScreenSize.height * 0.03),
            _EmailButton(email: model.instructorEmail),
            SizedBox(height: ScreenSize.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final AssignedMaterialModel model;
  const _HeaderCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize.width * 0.05),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.accent.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _HeaderStat(label: 'Code', value: model.code),
          _HeaderDivider(),
          _HeaderStat(label: 'Hours', value: '${model.hours} hrs'),
          _HeaderDivider(),
          _HeaderStat(
            label: 'Grade',
            value: model.grade,
            valueColor: _gradeColor(context, model.grade),
          ),
        ],
      ),
    );
  }

  Color _gradeColor(BuildContext context, String grade) {
    if (grade == 'No data yet') return context.textMuted;
    if (grade == 'F') return context.cs.error;
    if (grade.startsWith('A')) return const Color(0xFF81C784);
    return context.accent;
  }
}

class _HeaderStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _HeaderStat({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? context.accent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: context.textMuted, fontSize: 12),
        ),
      ],
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height * 0.045,
      width: 1,
      color: context.glassBorder,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: context.accent, size: 18),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: context.onBackground,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.045,
        vertical: ScreenSize.height * 0.012,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: Column(
        children: List.generate(children.length, (i) {
          return Column(
            children: [
              children[i],
              if (i != children.length - 1)
                Divider(color: context.divider, height: 1),
            ],
          );
        }),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
      child: Row(
        children: [
          Icon(icon, color: context.accent, size: 18),
          SizedBox(width: ScreenSize.width * 0.03),
          Text(
            label,
            style: TextStyle(color: context.textMuted, fontSize: 13),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: context.onBackground,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultsCard extends StatelessWidget {
  final AssignedMaterialModel model;
  const _ResultsCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenSize.width * 0.045),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ResultStat(label: 'Year Work', value: model.yearWork),
          _ResultStat(label: 'Final Exam', value: model.finalDegree),
          _ResultStat(label: 'Total', value: model.total),
        ],
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  final String label;
  final String value;
  const _ResultStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: context.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: context.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}

class _EmailButton extends StatelessWidget {
  final String email;
  const _EmailButton({required this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenSize.height * 0.062,
      child: ElevatedButton.icon(
        onPressed: () {
          BlocProvider.of<EmailHandlerCubit>(context).sendEmail(email);
        },
        icon: const Icon(Icons.email_outlined),
        label: const Text(
          'Email Instructor',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.accent,
          foregroundColor: context.cs.onSecondary,
          disabledBackgroundColor: context.accent.withOpacity(0.5),
          disabledForegroundColor: context.cs.onSecondary.withOpacity(0.54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
