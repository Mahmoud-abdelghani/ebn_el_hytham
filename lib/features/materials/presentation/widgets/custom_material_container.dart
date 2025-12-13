import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomMaterialContainer extends StatelessWidget {
  const CustomMaterialContainer({super.key, required this.txt1, this.txt2, this.ontap});
  final String txt1;
  final String? txt2;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenSize.height * 0.02,
          horizontal: ScreenSize.width * .05,
        ),
      
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              txt1,
              style: TextStyle(
                color: ColorGuid.mainColor,
                fontWeight: FontWeight.w400,
                fontSize: ScreenSize.height * 0.024,
              ),
            ),
            Text(
              txt2 ?? "Show",
              style: TextStyle(
                color: ColorGuid.mainColor,
                fontWeight: FontWeight.w400,
                fontSize: ScreenSize.height * 0.024,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
