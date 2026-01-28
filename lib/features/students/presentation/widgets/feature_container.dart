import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class FeatureContainer extends StatelessWidget {
  const FeatureContainer({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  });
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.02),
            boxShadow: [
              BoxShadow(
                color: ColorGuid.mainColor,
                blurStyle: BlurStyle.normal,
                offset: Offset(2, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                iconPath,
                width: ScreenSize.width * 0.12,
                height: ScreenSize.height * 0.06,
                fit: BoxFit.contain,
              ),
              Text(
                title,
                style: TextStyle(
                  color: ColorGuid.mainColor,
                  fontSize: ScreenSize.height * 0.015,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
