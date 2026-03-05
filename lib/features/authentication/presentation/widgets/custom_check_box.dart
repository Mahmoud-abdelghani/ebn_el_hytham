import 'package:ebn_el_hytham/core/utils/color_guid.dart';
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
          // [amber] replaces the old navy mainColor for checked state
          activeColor: ColorGuid.amber,
          // Dark text icon on amber fill
          checkColor: Color(0xFF161B22),
          // Unchecked border uses [boardersColor] for dark theme integration
          side: BorderSide(color: ColorGuid.boardersColor, width: 1.5),
          focusColor: ColorGuid.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          txt,
          style: TextStyle(
            // [textSecondary] — readable white-ish on the dark login card
            color: ColorGuid.textSecondary,
            fontSize: ScreenSize.height * 0.022,
          ),
        ),
      ],
    );
  }
}
