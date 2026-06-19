import 'dart:developer';

import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/data/models/enrolled_material_student_model.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/email_handler_cubit.dart';
import 'package:ebn_el_hytham/features/materials/presentation/cubit/instructor_materials_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

/// Route arguments: Map<String, int> { 'materialIndex': x, 'studentIndex': y }
class InstructorStudentDetailsScreen extends StatefulWidget {
  const InstructorStudentDetailsScreen({super.key});
  static const String routeName = 'InstructorStudentDetailsScreen';

  @override
  State<InstructorStudentDetailsScreen> createState() =>
      _InstructorStudentDetailsScreenState();
}

class _InstructorStudentDetailsScreenState
    extends State<InstructorStudentDetailsScreen> {
  final _yearWorkController = TextEditingController();
  final _finalController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _editMode = false;

  EnrolledMaterialStudentModel? _localStudent;
  bool _initialized = false;

  // Instructor id — stored on first successful load to use in re-fetch
  String _instructorId = '';

  @override
  void dispose() {
    _yearWorkController.dispose();
    _finalController.dispose();
    super.dispose();
  }

  void _initLocal(EnrolledMaterialStudentModel source, String instructorId) {
    if (_initialized) return;
    _initialized = true;
    _instructorId = instructorId;
    _localStudent = EnrolledMaterialStudentModel(
      id: source.id,
      name: source.name,
      email: source.email,
      yearWork: source.yearWork,
      finalDegree: source.finalDegree,
      total: source.total,
    );
    _yearWorkController.text = source.yearWork > 0
        ? source.yearWork.toString()
        : '';
    _finalController.text = source.finalDegree > 0
        ? source.finalDegree.toString()
        : '';
  }

  void _saveEdits() {
    if (!_formKey.currentState!.validate()) return;
    final yw = int.parse(_yearWorkController.text);
    final fd = int.parse(_finalController.text);
    setState(() {
      _localStudent!.yearWork = yw;
      _localStudent!.finalDegree = fd;
      _localStudent!.total = yw + fd;
      _editMode = false;
    });
  }

  void _cancelEdit() {
    _yearWorkController.text = _localStudent!.yearWork > 0
        ? _localStudent!.yearWork.toString()
        : '';
    _finalController.text = _localStudent!.finalDegree > 0
        ? _localStudent!.finalDegree.toString()
        : '';
    setState(() => _editMode = false);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    final materialIndex = args['materialIndex']!;
    final studentIndex = args['studentIndex']!;

    return BlocConsumer<InstructorMaterialsCubit, InstructorMaterialsState>(
      // ── Listen: react to update success / failure ──────────────────────
      listenWhen: (_, current) =>
          current is InstructorMaterialsUpdateSuccess ||
          current is InstructorMaterialsUpdateFailure,
      listener: (context, state) async {
        if (state is InstructorMaterialsUpdateSuccess) {
          // Re-fetch so the instructor sees live data immediately

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text('Grades saved successfully'),
                  ],
                ),
                backgroundColor: const Color(0xFF2E7D32),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(ScreenSize.width * 0.04),
              ),
            );
          }
        } else if (state is InstructorMaterialsUpdateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(state.message)),
                ],
              ),
              backgroundColor: const Color(0xFFC62828),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.all(ScreenSize.width * 0.04),
            ),
          );
        }
      },
      // ── Build ──────────────────────────────────────────────────────────
      builder: (context, state) {
        if (state is InstructorMaterialsLoading) {
          return Scaffold(
            backgroundColor: context.scaffold,
            appBar: buildDarkAppBar(context, ''),
            body: const _StudentDetailsShimmer(),
          );
        }

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

        // Keep showing current data while update is in-flight or just finished
        if (state is! InstructorMaterialsSuccess &&
            state is! InstructorMaterialsUpdatreLoading &&
            state is! InstructorMaterialsUpdateSuccess &&
            state is! InstructorMaterialsUpdateFailure) {
          return const Scaffold();
        }

        // Pull material from cubit's cached list during update states
        final cubit = BlocProvider.of<InstructorMaterialsCubit>(context);
        final material = cubit.materialsGlobal.isNotEmpty
            ? cubit.materialsGlobal[materialIndex]
            : (state as InstructorMaterialsSuccess).materials[materialIndex];

        // !! Pass instructor id — adjust this to your actual source !!
        // e.g. from SharedPreferences / auth cubit; here we use material code
        // as placeholder until you wire the real instructor id.
        _initLocal(material.assignedMaterials[studentIndex], material.code);
        final student = _localStudent!;

        final isUpdating = state is InstructorMaterialsUpdatreLoading;

        return Scaffold(
          backgroundColor: context.scaffold,
          appBar: buildDarkAppBar(context, material.name),
          floatingActionButton: _editMode ? null : _EmailFAB(student: student),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.width * 0.05,
              vertical: ScreenSize.height * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IdentityCard(student: student, material: material),
                SizedBox(height: ScreenSize.height * 0.022),
                _SectionLabel(label: 'Grade Details'),
                SizedBox(height: ScreenSize.height * 0.012),
                _GradesCard(
                  student: student,
                  editMode: _editMode,
                  yearWorkController: _yearWorkController,
                  finalController: _finalController,
                  formKey: _formKey,
                ),
                SizedBox(height: ScreenSize.height * 0.022),
                _editMode
                    ? _EditActions(onCancel: _cancelEdit, onSave: _saveEdits)
                    : _ActionButtons(
                        isLoading: isUpdating,
                        onEdit: () => setState(() => _editMode = true),
                        onSave: () {
                          log('${student.yearWork}');
                          cubit.updateDegrees(
                            studentId: int.parse(student.id),
                            courseCode: material.code,
                            yearWork: student.yearWork,
                            finalExam: student.finalDegree,
                          );
                        },
                      ),
                SizedBox(height: ScreenSize.height * 0.04),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─── Shimmer ──────────────────────────────────────────────────────────────────

class _StudentDetailsShimmer extends StatelessWidget {
  const _StudentDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.surface,
      highlightColor: context.accent.withOpacity(0.15),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width * 0.05),
        child: Column(
          children: [
            _ShimmerBox(height: ScreenSize.height * 0.22),
            SizedBox(height: ScreenSize.height * 0.02),
            _ShimmerBox(height: ScreenSize.height * 0.28),
            SizedBox(height: ScreenSize.height * 0.02),
            _ShimmerBox(height: ScreenSize.height * 0.065),
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
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

// ─── Identity Card ────────────────────────────────────────────────────────────

class _IdentityCard extends StatelessWidget {
  final EnrolledMaterialStudentModel student;
  final InstructorMaterialModel material;
  const _IdentityCard({required this.student, required this.material});

  Color _totalColor(BuildContext context) {
    if (student.total >= 85) return const Color(0xFF81C784);
    if (student.total >= 60) return context.accent;
    if (student.total >= 50) return const Color(0xFFFFB74D);
    return const Color(0xFFEF5350);
  }

  @override
  Widget build(BuildContext context) {
    final totalColor = _totalColor(context);
    return Container(
      padding: EdgeInsets.all(ScreenSize.width * 0.05),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.glassBorder, width: 1.2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: ScreenSize.height * 0.075,
                height: ScreenSize.height * 0.075,
                decoration: BoxDecoration(
                  color: context.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.accent, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    student.name.isNotEmpty
                        ? student.name.trim()[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: context.accent,
                      fontSize: ScreenSize.height * 0.032,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: TextStyle(
                        color: context.onBackground,
                        fontSize: ScreenSize.height * 0.02,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.004),
                    Text(
                      'ID: ${student.id}',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: ScreenSize.height * 0.015,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.004),
                    Text(
                      student.email,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF64B5F6),
                        fontSize: ScreenSize.height * 0.014,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenSize.height * 0.07,
                height: ScreenSize.height * 0.07,
                decoration: BoxDecoration(
                  color: totalColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: totalColor, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${student.total}',
                      style: TextStyle(
                        color: totalColor,
                        fontSize: ScreenSize.height * 0.02,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                        color: totalColor.withOpacity(0.8),
                        fontSize: ScreenSize.height * 0.011,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.018),
          Divider(color: context.divider, height: 1),
          SizedBox(height: ScreenSize.height * 0.015),
          Row(
            children: [
              Expanded(
                child: _MiniInfo(
                  icon: Icons.menu_book_rounded,
                  label: 'Course',
                  value: material.name,
                ),
              ),
              Expanded(
                child: _MiniInfo(
                  icon: Icons.location_on_rounded,
                  label: 'Hall',
                  value: material.location,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.01),
          Row(
            children: [
              Expanded(
                child: _MiniInfo(
                  icon: Icons.layers_rounded,
                  label: 'Level',
                  value: material.level,
                ),
              ),
              Expanded(
                child: _MiniInfo(
                  icon: Icons.calendar_month_rounded,
                  label: 'Day',
                  value: material.day,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _MiniInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: context.accent, size: ScreenSize.height * 0.018),
        SizedBox(width: ScreenSize.width * 0.015),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: context.textMuted,
                  fontSize: ScreenSize.height * 0.012,
                ),
              ),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.onBackground,
                  fontSize: ScreenSize.height * 0.015,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Grades Card ─────────────────────────────────────────────────────────────

class _GradesCard extends StatelessWidget {
  final EnrolledMaterialStudentModel student;
  final bool editMode;
  final TextEditingController yearWorkController;
  final TextEditingController finalController;
  final GlobalKey<FormState> formKey;

  const _GradesCard({
    required this.student,
    required this.editMode,
    required this.yearWorkController,
    required this.finalController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenSize.width * 0.05),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.glassBorder, width: 1.2),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _GradeRow(
              label: 'Year Work',
              value: student.yearWork,
              color: const Color(0xFF64B5F6),
              icon: Icons.book_rounded,
              editMode: editMode,
              controller: yearWorkController,
              crossValidator: (yw) {
                final fd = int.tryParse(finalController.text) ?? 0;
                if (yw + fd > 100) return 'Total = ${yw + fd} — exceeds 100';
                return null;
              },
            ),
            SizedBox(height: ScreenSize.height * 0.018),
            Divider(color: context.divider, height: 1),
            SizedBox(height: ScreenSize.height * 0.018),
            _GradeRow(
              label: 'Final Exam',
              value: student.finalDegree,
              color: const Color(0xFFBA68C8),
              icon: Icons.assignment_turned_in_rounded,
              editMode: editMode,
              controller: finalController,
              crossValidator: (fd) {
                final yw = int.tryParse(yearWorkController.text) ?? 0;
                if (yw + fd > 100) return 'Total = ${yw + fd} — exceeds 100';
                return null;
              },
            ),
            SizedBox(height: ScreenSize.height * 0.018),
            Divider(color: context.divider, height: 1),
            SizedBox(height: ScreenSize.height * 0.018),
            Row(
              children: [
                Icon(
                  Icons.calculate_rounded,
                  color: context.accent,
                  size: ScreenSize.height * 0.022,
                ),
                SizedBox(width: ScreenSize.width * 0.03),
                Text(
                  'Total Score',
                  style: TextStyle(
                    color: context.onBackground,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSize.width * 0.04,
                    vertical: ScreenSize.height * 0.007,
                  ),
                  decoration: BoxDecoration(
                    color: context.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: context.accent.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${student.total} / 100',
                    style: TextStyle(
                      color: context.accent,
                      fontSize: ScreenSize.height * 0.018,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Grade Row ────────────────────────────────────────────────────────────────

class _GradeRow extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;
  final bool editMode;
  final TextEditingController controller;
  final String? Function(int parsed)? crossValidator;

  const _GradeRow({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    required this.editMode,
    required this.controller,
    this.crossValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: ScreenSize.height * 0.022),
            SizedBox(width: ScreenSize.width * 0.03),
            Text(
              label,
              style: TextStyle(
                color: context.onBackground,
                fontSize: ScreenSize.height * 0.017,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            editMode
                ? SizedBox(
                    width: ScreenSize.width * 0.35,
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: color,
                        fontSize: ScreenSize.height * 0.017,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.02,
                          vertical: ScreenSize.height * 0.009,
                        ),
                        filled: true,
                        fillColor: context.scaffold,
                        hintText: '0 – 100',
                        hintStyle: TextStyle(
                          color: context.textMuted,
                          fontSize: ScreenSize.height * 0.013,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: color, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: color.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: color, width: 1.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEF5350),
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFEF5350),
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = int.tryParse(v);
                        if (n == null || n < 0 || n > 100) return '0 – 100';
                        return crossValidator?.call(n);
                      },
                    ),
                  )
                : Text(
                    '$value',
                    style: TextStyle(
                      color: color,
                      fontSize: ScreenSize.height * 0.018,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
          ],
        ),
        SizedBox(height: ScreenSize.height * 0.008),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: (value / 100).clamp(0.0, 1.0),
            minHeight: ScreenSize.height * 0.006,
            backgroundColor: context.glassBorder,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

// ─── Action Buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final bool isLoading; // true while InstructorMaterialsUpdatreLoading

  const _ActionButtons({
    required this.onEdit,
    required this.onSave,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Edit button ──────────────────────────────────────────────────
        GestureDetector(
          onTap: isLoading ? null : onEdit,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.016),
            decoration: BoxDecoration(
              color: isLoading
                  ? context.accent.withOpacity(0.5)
                  : context.accent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit_rounded,
                  color: context.cs.onSecondary,
                  size: ScreenSize.height * 0.022,
                ),
                SizedBox(width: ScreenSize.width * 0.02),
                Text(
                  'Edit Grades',
                  style: TextStyle(
                    color: context.cs.onSecondary,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenSize.height * 0.012),
        // ── Save to server button — shows CircularProgressIndicator ──────
        GestureDetector(
          onTap: isLoading ? null : onSave,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.016),
            decoration: BoxDecoration(
              color: context.accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.accent.withOpacity(isLoading ? 0.2 : 0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Swap icon ↔ spinner based on loading state
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: isLoading
                      ? SizedBox(
                          key: const ValueKey('spinner'),
                          width: ScreenSize.height * 0.022,
                          height: ScreenSize.height * 0.022,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.accent,
                            ),
                          ),
                        )
                      : Icon(
                          key: const ValueKey('icon'),
                          Icons.cloud_upload_rounded,
                          color: context.accent,
                          size: ScreenSize.height * 0.022,
                        ),
                ),
                SizedBox(width: ScreenSize.width * 0.02),
                Text(
                  isLoading ? 'Saving…' : 'Save to Server',
                  style: TextStyle(
                    color: isLoading
                        ? context.accent.withOpacity(0.6)
                        : context.accent,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EditActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  const _EditActions({required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.016,
              ),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.glassBorder, width: 1),
              ),
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: context.onSurfaceMuted,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenSize.width * 0.03),
        Expanded(
          child: GestureDetector(
            onTap: onSave,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.016,
              ),
              decoration: BoxDecoration(
                color: context.accent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    color: context.cs.onSecondary,
                    fontSize: ScreenSize.height * 0.017,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Email FAB ────────────────────────────────────────────────────────────────

class _EmailFAB extends StatelessWidget {
  final EnrolledMaterialStudentModel student;
  const _EmailFAB({required this.student});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        BlocProvider.of<EmailHandlerCubit>(context).sendEmail(student.email);
      },
      backgroundColor: context.accent,
      icon: Icon(Icons.email_rounded, color: context.cs.onSecondary),
      label: Text(
        'Email Student',
        style: TextStyle(
          color: context.cs.onSecondary,
          fontWeight: FontWeight.w700,
          fontSize: ScreenSize.height * 0.015,
        ),
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenSize.width * 0.009,
          height: ScreenSize.height * 0.022,
          decoration: BoxDecoration(
            color: context.accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: ScreenSize.width * 0.025),
        Text(
          label,
          style: TextStyle(
            color: context.onBackground,
            fontSize: ScreenSize.height * 0.019,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
