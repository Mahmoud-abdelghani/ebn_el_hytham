import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    required this.txt,
  });
  final bool value;
  final Function(bool?)? onChanged;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          focusColor: ColorGuid.mainColor,
          checkColor: Colors.white,
          activeColor: ColorGuid.mainColor,
        ),
        Text(
          txt,
          style: TextStyle(
            color: ColorGuid.mainColor,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ],
    );
  }
}
