import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.txt,
    required this.color,
    required this.onTap,
  });
  final String txt;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        txt,
        style: TextStyle(
          color: color == ColorGuid.mainColor
              ? Colors.white
              : ColorGuid.mainColor,
          fontSize: ScreenSize.height * 0.025,
        ),
      ),
    );
  }
}
