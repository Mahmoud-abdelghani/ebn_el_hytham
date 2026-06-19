import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Custom checkbox with amber active color matching the dark design theme
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
          activeColor: context.accent,
          checkColor: context.cs.onSecondary,
          side: BorderSide(color: context.borderColor, width: 1.5),
          focusColor: context.accent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          txt,
          style: TextStyle(
            color: context.onSurfaceMuted,
            fontSize: ScreenSize.height * 0.022,
          ),
        ),
      ],
    );
  }
}
