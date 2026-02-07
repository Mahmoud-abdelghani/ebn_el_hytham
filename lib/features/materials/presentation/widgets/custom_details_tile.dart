import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomDetailsTile extends StatelessWidget {
  const CustomDetailsTile({
    super.key,
    required this.name,
    required this.id,
    required this.onTap,
    this.mark
  });
  final String name;
  final String id;
  final VoidCallback onTap;
  final String? mark;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ColorGuid.mainColor,
                blurStyle: BlurStyle.normal,
                offset: Offset(2, 2),
                blurRadius: 2,
              ),
            ],
          ),

          child: ListTile(
            title: Text(
              name,
              style: TextStyle(
                color: ColorGuid.mainColor,
                fontWeight: FontWeight.w400,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
            leading: CircleAvatar(
              radius: ScreenSize.height * 0.03,
              backgroundColor: ColorGuid.scaffoldBackgroundColor,
              backgroundImage: NetworkImage(
                'https://astra.edu.au/wp-content/uploads/2022/02/student-information-uai-1000x562.jpg',
              ),
            ),
            subtitle: Text(
              id,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: ScreenSize.height * 0.015,
              ),
            ),
            trailing: Text(
             mark?? 'Show',
              style: TextStyle(
                color: ColorGuid.mainColor,
                fontWeight: FontWeight.w500,
                fontSize: ScreenSize.height * 0.02,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
