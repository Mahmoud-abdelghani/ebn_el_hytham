import 'dart:developer';
import 'dart:io';

import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/attendance_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/image_processing_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/attendance_action_buttons.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/attendance_date_picker.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/attendance_image_picker.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/attendance_material_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key, required this.assignedMaterials});
  final List<String> assignedMaterials;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  DateTime? selectedDate;
  String selectedMaterial = 'ShooseMaterial';
  File? pickedImage;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _onConfirm() async {
    if (pickedImage == null ||
        selectedDate == null ||
        selectedMaterial == 'ShooseMaterial') {
      _showError('Please complete all fields');
      return;
    }
    await context.read<ImageProcessingCubit>().imageToUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceSuccess) {
          _showSuccess('Attendance submitted successfully');
          Navigator.pop(context);
        } else if (state is AttendanceError) {
          _showError(state.message);
        }
      },
      builder: (context, attendanceState) {
        return BlocConsumer<ImageProcessingCubit, ImageProcessingState>(
          listener: (context, state) async {
            if (state is ImageProcessingSuccess) {
              log(context.read<ImageProcessingCubit>().iamgeUrl.toString());
              _showSuccess('Image uploaded successfully');
              await context.read<AttendanceCubit>().getAttendance(
                    url: context.read<ImageProcessingCubit>().iamgeUrl!,
                    date: DateFormat('yyyy-MM-dd').format(selectedDate!),
                    materialName: selectedMaterial,
                  );
            } else if (state is ImageProcessingError) {
              _showError(state.message);
            }
          },
          builder: (context, imageState) {
            final bool isLoading = imageState is ImageProcessingLoading ||
                attendanceState is AttendanceLoading;

            return ModalProgressHUD(
              inAsyncCall: isLoading,
              color: Colors.black54,
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.05,
                  vertical: ScreenSize.height * 0.08,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2330),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: ColorGuid.amber.withOpacity(0.06),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(ScreenSize.width * 0.05),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Title row ────────────────────────────────
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 22,
                            decoration: BoxDecoration(
                              color: ColorGuid.amber,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Attendance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSize.height * 0.026,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.close_rounded,
                                  color: Colors.white54, size: 18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenSize.height * 0.024),

                      // ── Image picker ─────────────────────────────
                      AttendanceImagePicker(
                        pickedImage: pickedImage,
                        onTap: () async {
                          final image = await context
                              .read<ImageProcessingCubit>()
                              .getImage();
                          setState(() => pickedImage = image);
                        },
                      ),
                      SizedBox(height: ScreenSize.height * 0.016),

                      // ── Date picker ──────────────────────────────
                      AttendanceDatePicker(
                        selectedDate: selectedDate,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: ColorGuid.amber,
                                  surface: const Color(0xFF1C2330),
                                ),
                              ),
                              child: child!,
                            ),
                          );
                          if (date != null) {
                            setState(() => selectedDate = date);
                          }
                        },
                      ),
                      SizedBox(height: ScreenSize.height * 0.016),

                      // ── Material dropdown ────────────────────────
                      AttendanceMaterialDropdown(
                        selectedMaterial: selectedMaterial,
                        materials: widget.assignedMaterials,
                        onSelected: (m) => setState(() => selectedMaterial = m),
                      ),
                      SizedBox(height: ScreenSize.height * 0.028),

                      // ── Action buttons ───────────────────────────
                      AttendanceActionButtons(
                        onCancel: () => Navigator.maybePop(context),
                        onConfirm: _onConfirm,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}