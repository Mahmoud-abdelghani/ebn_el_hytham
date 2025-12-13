import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.txt});
  final VoidCallback onTap;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: ColorGuid.mainColor,
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.01,
        horizontal: ScreenSize.width * 0.2,
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: ScreenSize.height * 0.025,
        ),
      ),
    );
  }
}
