import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

/// Small paired data container used in row layouts (e.g., timetable, material details).
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
        color: context.surface,
        border: Border.all(color: context.cardBorder),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
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
          color: context.onBackground,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.0175,
        ),
      ),
    );
  }
}
