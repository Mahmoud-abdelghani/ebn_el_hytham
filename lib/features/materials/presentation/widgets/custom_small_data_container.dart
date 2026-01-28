import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomSmallDataContainer extends StatelessWidget {
  const CustomSmallDataContainer({
    super.key,
    required this.data,
    required this.textDirection,
  });
  final String data;
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.01),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.01,
        horizontal: ScreenSize.width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: ColorGuid.boardersColor),
      ),
      width: ScreenSize.width * 0.45,
      child: Text(
        data,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: textDirection,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
    );
  }
}
