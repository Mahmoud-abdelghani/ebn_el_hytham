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
      backgroundColor: Colors.white,
      title: Text(
        'Attendance',
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w600,
          fontSize: ScreenSize.height * 0.03,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                      radius: Radius.circular(10),
                      color: ColorGuid.boardersColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.1,
                        vertical: ScreenSize.height * 0.1,
                      ),
                    ),
                    child: Text(
                      'Upload an image here',
                      style: TextStyle(
                        color: ColorGuid.boardersColor,
                        fontSize: ScreenSize.height * 0.015,
                      ),
                    ),
                  )
                : Image.file(
                    pickedImage!,
                    width: ScreenSize.width * 0.7,
                    height: ScreenSize.height * 0.3,
                    fit: BoxFit.fill,
                  ),
          ),
          GestureDetector(
            onTap: () async {
              selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
                onDatePickerModeChange: (value) {},
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      brightness: Brightness.light,
                      primary: ColorGuid.mainColor,
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
                vertical: ScreenSize.height * 0.02,
              ),
              padding: EdgeInsets.only(
                top: ScreenSize.height * 0.01,
                bottom: ScreenSize.height * 0.01,
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ColorGuid.boardersColor,
                  width: ScreenSize.width * .001,
                ),
              ),
              width: ScreenSize.width,
              child: selectedDate == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'YYYY/MM/dd',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ColorGuid.boardersColor,
                            fontSize: ScreenSize.height * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(Icons.calendar_month, color: Colors.grey),
                      ],
                    )
                  : Center(
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(selectedDate!),
                        style: TextStyle(
                          color: ColorGuid.mainColor,
                          fontSize: ScreenSize.height * 0.02,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
          ),
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
                color: Colors.white,
                items: List.generate(
                  materials.length,
                  (index) => PopupMenuItem(
                    child: Text(materials[index].name),
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
                vertical: ScreenSize.height * 0.02,
              ),
              padding: EdgeInsets.only(
                top: ScreenSize.height * 0.01,
                bottom: ScreenSize.height * 0.01,
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ColorGuid.boardersColor,
                  width: ScreenSize.width * .001,
                ),
              ),
              width: ScreenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectedMaterial == 'ShooseMaterial'
                      ? Text(
                          'Shoose Material',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          selectedMaterial,
                          style: TextStyle(
                            color: ColorGuid.mainColor,
                            fontSize: ScreenSize.height * 0.015,
                          ),
                        ),
                  Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          txt: 'Cancel',
          color: ColorGuid.scaffoldBackgroundColor,
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
        CustomElevatedButton(
          txt: 'Confirm',
          color: ColorGuid.mainColor,
          onTap: () {
            if (selectedDate == null ||
                selectedMaterial == 'ShooseMaterial' ||
                pickedImage == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'complete attendance information',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(milliseconds: 700),
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
