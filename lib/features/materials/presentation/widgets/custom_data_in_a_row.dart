import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:ebn_el_hytham/features/materials/presentation/widgets/custom_small_data_container.dart';
import 'package:flutter/material.dart';

class CustomDataInARow extends StatelessWidget {
  const CustomDataInARow({super.key, required this.txtLeft, required this.txtRight});

  final String txtLeft;
  final String txtRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomSmallDataContainer(
          data:txtLeft ,
          textDirection: TextDirection.ltr, virticalMargin: ScreenSize.height*0.01,
        ),
        CustomSmallDataContainer(
          data: txtRight,
          textDirection: TextDirection.ltr, virticalMargin: ScreenSize.height*0.01,  
        ),
      ],
    );
  }
}
