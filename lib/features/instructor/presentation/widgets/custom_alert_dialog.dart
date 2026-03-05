import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/cubit/image_processing_cubit.dart';
import 'package:ebn_el_hytham/features/instructor/presentation/widgets/custom_elevated_button.dart';
import 'package:ebn_el_hytham/features/materials/data/models/instructor_material_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// Dark-themed attendance dialog — [surfaceColor] background, [amber] accents.
class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  DateTime? selectedDate;
  String selectedMaterial = 'ShooseMaterial';
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // [surfaceColor] dark dialog background
      backgroundColor: ColorGuid.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: ColorGuid.glassBorder, width: 1.2),
      ),
      // Dialog title in [textPrimary]
      title: Text(
        'Attendance',
        style: TextStyle(
          color: ColorGuid.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: ScreenSize.height * 0.028,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Image upload zone — dotted border in [amber] ─────────
          GestureDetector(
            onTap: () async {
              pickedImage = await BlocProvider.of<ImageProcessingCubit>(
                context,
              ).getImage();
              setState(() {});
            },
            child: pickedImage == null
                ? DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: const Radius.circular(10),
                      // [amber] dotted border for upload area
                      color: ColorGuid.amber,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.1,
                        vertical: ScreenSize.height * 0.1,
                      ),
                    ),
                    child: Text(
                      'Upload an image here',
                      style: TextStyle(
                        color: ColorGuid.textMuted, // [textMuted] placeholder
                        fontSize: ScreenSize.height * 0.015,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      pickedImage!,
                      width: ScreenSize.width * 0.7,
                      height: ScreenSize.height * 0.3,
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
          SizedBox(height: ScreenSize.height * 0.015),
          // ── Date picker row — [surfaceColor] input ───────────────
          GestureDetector(
            onTap: () async {
              selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now(),
                onDatePickerModeChange: (value) {},
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.dark(
                      primary: ColorGuid.amber, // [amber] selected date highlight
                      surface: ColorGuid.surfaceColor,
                      onSurface: ColorGuid.textPrimary,
                    ),
                  ),
                  child: child!,
                ),
              );
              setState(() {});
              log(selectedDate.toString());
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.1,
                vertical: ScreenSize.height * 0.01,
              ),
              padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.012,
              ),
              decoration: BoxDecoration(
                // [surfaceColor] input row
                color: ColorGuid.scaffoldBackgroundColor,
                border: Border.all(color: ColorGuid.boardersColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selectedDate == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'YYYY/MM/dd',
                          style: TextStyle(
                            color: ColorGuid.textMuted, // [textMuted] placeholder
                            fontSize: ScreenSize.height * 0.018,
                          ),
                        ),
                        Icon(Icons.calendar_month, color: ColorGuid.textSecondary),
                      ],
                    )
                  : Center(
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(selectedDate!),
                        style: TextStyle(
                          color: ColorGuid.amber, // [amber] selected date
                          fontSize: ScreenSize.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ),
          // ── Material selector dropdown ────────────────────────────
          GestureDetector(
            onTap: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  ScreenSize.width * 0.22,
                  ScreenSize.height * 0.7,
                  ScreenSize.width * 0.21,
                  0,
                ),
                // [surfaceColor] popup background
                color: ColorGuid.surfaceColor,
                items: List.generate(
                  materials.length,
                  (index) => PopupMenuItem(
                    child: Text(
                      materials[index].name,
                      style: TextStyle(color: ColorGuid.textPrimary),
                    ),
                    onTap: () {
                      selectedMaterial = materials[index].name;
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.1,
                vertical: ScreenSize.height * 0.01,
              ),
              padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
              decoration: BoxDecoration(
                color: ColorGuid.scaffoldBackgroundColor,
                border: Border.all(color: ColorGuid.boardersColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedMaterial == 'ShooseMaterial'
                      ? Text(
                          'Choose Material',
                          style: TextStyle(color: ColorGuid.textMuted),
                        )
                      : Text(
                          selectedMaterial,
                          style: TextStyle(
                            color: ColorGuid.amber, // [amber] selected material
                            fontSize: ScreenSize.height * 0.016,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorGuid.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        // Cancel button — [surfaceColor] themed
        CustomElevatedButton(
          txt: 'Cancel',
          color: ColorGuid.surfaceColor, // maps to secondary styling
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
        // Confirm button — [amber] themed
        CustomElevatedButton(
          txt: 'Confirm',
          color: ColorGuid.amber, // [amber] primary action
          onTap: () {
            if (selectedDate == null ||
                selectedMaterial == 'ShooseMaterial' ||
                pickedImage == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Complete attendance information',
                    style: TextStyle(color: Color(0xFF161B22)),
                  ),
                  // [error] snackbar for incomplete form
                  backgroundColor: ColorGuid.error,
                  duration: const Duration(milliseconds: 700),
                ),
              );
            } else {
              Navigator.maybePop(context);
            }
          },
        ),
      ],
    );
  }
}
