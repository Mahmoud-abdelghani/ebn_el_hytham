import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class ExamWidget extends StatelessWidget {
  const ExamWidget({
    super.key,
    required this.name,
    required this.date,
    required this.location,
    required this.chairNum,
    required this.next,
  });
  final String name;
  final String date;
  final String location;
  final String chairNum;
  final bool next;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border.all(
        color: next ? ColorGuid.mainColor : Colors.white,
        width: ScreenSize.width * 0.01,
      ),
      tileColor: Colors.white,
      minTileHeight: ScreenSize.height * 0.11,
      leading: Text(
        name,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.017,
        ),
      ),
      dense: true,
      subtitle: Text(
        location,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.015,
        ),
      ),
      title: Text(
        date,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.018,
        ),
      ),
      trailing: Text(
        chairNum,
        style: TextStyle(
          color: ColorGuid.mainColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenSize.height * 0.02,
        ),
      ),
    );
  }
}
