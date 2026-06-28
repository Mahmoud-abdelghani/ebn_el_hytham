import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Dark-themed primary action button with amber fill and press animation
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.txt});
  final VoidCallback onTap;
  final Widget txt;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: context.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 6,
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.014,
        horizontal: ScreenSize.width * 0.2,
      ),
      child: txt,
    );
  }
}
