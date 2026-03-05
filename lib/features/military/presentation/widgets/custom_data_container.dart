import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Dark glass data container used in Military, Layha, and detail screens.
/// [surfaceColor] fill + [boardersColor] border + [textPrimary] text
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
        // [surfaceColor] — dark card surface replaces old white
        color: ColorGuid.surfaceColor,
        // [glassBorder] subtle white haze border
        border: Border.all(color: ColorGuid.glassBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
          color: ColorGuid.textPrimary, // [textPrimary] white text
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
    );
  }
}
