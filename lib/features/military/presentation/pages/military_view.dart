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
      backgroundColor: ColorGuid.scaffoldBackgroundColor,
      appBar: AppBar(
        shadowColor: ColorGuid.mainColor,
        elevation: 8,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorGuid.mainColor,
        centerTitle: true,
        title: Text(
          "Military",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.height * 0.025,
          ),
        ),
      ),
      body: Column(
        spacing: ScreenSize.height * 0.05,
        children: [
          SizedBox(height: ScreenSize.height * 0.05),
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
