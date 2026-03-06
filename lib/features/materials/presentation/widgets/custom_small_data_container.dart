import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Small paired data container used in row layouts (e.g., timetable, material details).
/// Dark [surfaceColor] card with [boardersColor] border and [textPrimary] text.
class CustomSmallDataContainer extends StatelessWidget {
  const CustomSmallDataContainer({
    super.key,
    required this.data,
    required this.textDirection,
    required this.virticalMargin,
  });
  final String data;
  final TextDirection textDirection;
  final double virticalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: virticalMargin),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.012,
        horizontal: ScreenSize.width * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // [surfaceColor] — dark card replaces old white bg
        color: ColorGuid.surfaceColor,
        // [boardersColor] border replaces old grey border
        border: Border.all(color: ColorGuid.boardersColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: ScreenSize.width * 0.45,
      child: Text(
        data,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: textDirection,
        style: TextStyle(
          color: ColorGuid.textPrimary, // [textPrimary] white
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.0175,
        ),
      ),
    );
  }
}
