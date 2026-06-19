import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenSize.width * 0.008,
          height: ScreenSize.height * 0.022,
          decoration: BoxDecoration(
            color: context.accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: ScreenSize.width * 0.025),
        Text(
          label,
          style: TextStyle(
            color: context.onBackground,
            fontSize: ScreenSize.height * 0.019,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
