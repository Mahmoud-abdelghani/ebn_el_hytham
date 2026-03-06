import 'package:ebn_el_hytham/core/utils/app_bar_builder.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/military/presentation/widgets/custom_data_container.dart';
import 'package:flutter/material.dart';

class MilitaryView extends StatelessWidget {
  const MilitaryView({super.key});
  static const String routeName = 'MilitaryView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [scaffoldBackgroundColor] dark charcoal
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: buildDarkAppBar('Military'),
      body: Column(
        children: [
          SizedBox(height: ScreenSize.height * 0.04),
          // Army badge icon in amber ring
          Center(
            child: Container(
              width: ScreenSize.width * 0.2,
              height: ScreenSize.width * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorGuid.amberSubtle, // [amberSubtle] icon bg
                border: Border.all(color: ColorGuid.amber, width: 2),
              ),
              child: Icon(
                Icons.shield_outlined,
                color: ColorGuid.amber, // [amber] icon
                size: ScreenSize.width * 0.1,
              ),
            ),
          ),
          SizedBox(height: ScreenSize.height * 0.035),
          // Data containers — dark-themed via updated CustomDataContainer
          CustomDataContainer(
            data: "12/12/2024",
            textDirection: TextDirection.ltr,
          ),
          CustomDataContainer(
            data: 'قام بأداء التربية العسكريه',
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
