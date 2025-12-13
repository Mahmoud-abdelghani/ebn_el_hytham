import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class StudentProfileStringsHelper extends StatelessWidget {
  const StudentProfileStringsHelper({
    super.key,
    required this.firstTxt,
    this.secondTxt,
  });
  final String firstTxt;
  final String? secondTxt;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstTxt,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorGuid.mainColor,
            fontWeight: FontWeight.w400,
            fontSize: ScreenSize.height * 0.02,
          ),
        ),
        secondTxt != null
            ? Text(
                secondTxt!,
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.02,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
