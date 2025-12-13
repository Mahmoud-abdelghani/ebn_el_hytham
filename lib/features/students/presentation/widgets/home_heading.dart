import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class HomeHeading extends StatelessWidget {
  const HomeHeading({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.email,
  });
  final String imageUrl;
  final String name;
  final String id;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Rectangle 6541.png',
          width: ScreenSize.width,
          height: ScreenSize.height * 0.35,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.0486111111121238,
            vertical: ScreenSize.height * 0.0555625000239258,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: ScreenSize.height * 0.035,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Text(
                    "Faculity of Engineering",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenSize.height * 0.02,
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    size: ScreenSize.height * 0.045,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.height * 0.0185),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.025,
                ),
              ),
              Text(
                "$id | $email",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorGuid.boardersColor,
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenSize.height * 0.017,
                ),
              ),
              Divider(color: ColorGuid.boardersColor),
            ],
          ),
        ),
      ],
    );
  }
}
