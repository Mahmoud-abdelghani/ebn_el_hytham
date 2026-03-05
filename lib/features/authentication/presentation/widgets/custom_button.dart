import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Dark-themed primary action button with amber fill and press animation
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.txt});
  final VoidCallback onTap;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      // [amber] accent fill — replaces old mainColor blue
      color: ColorGuid.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.014,
        horizontal: ScreenSize.width * 0.2,
      ),
      child: Text(
        txt,
        style: TextStyle(
          // Dark text on amber for maximum contrast
          color: Color(0xFF161B22),
          fontWeight: FontWeight.bold,
          fontSize: ScreenSize.height * 0.022,
        ),
      ),
    );
  }
}
