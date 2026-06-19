import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Themed data container used in Military, Layha, and detail screens.
class CustomDataContainer extends StatelessWidget {
  const CustomDataContainer({
    super.key,
    required this.data,
    required this.textDirection,
  });
  final String data;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.01,
        horizontal: ScreenSize.width * 0.035,
      ),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.014,
        horizontal: ScreenSize.width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.surface,
        border: Border.all(color: context.glassBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: ScreenSize.width,
      child: Text(
        data,
        textDirection: textDirection,
        style: TextStyle(
          color: context.onBackground,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
    );
  }
}
