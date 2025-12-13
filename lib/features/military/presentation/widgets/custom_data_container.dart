import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomDataContainer extends StatelessWidget {
  const CustomDataContainer({super.key, required this.data, required this.textDecoration});
  final String data;
  final TextDirection? textDecoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.01,
        horizontal: ScreenSize.width * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: ColorGuid.boardersColor),
      ),
      width: ScreenSize.width,
      child: Text(
        data,
        textDirection: textDecoration ,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.03,
        ),
      ),
    );
  }
}
