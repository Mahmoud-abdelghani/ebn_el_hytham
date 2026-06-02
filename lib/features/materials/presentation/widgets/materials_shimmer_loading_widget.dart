import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MaterialsShimmerLoading extends StatelessWidget {
  const MaterialsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.05,
        vertical: ScreenSize.height * 0.025,
      ),
      itemCount: 5,
      separatorBuilder: (_, __) => SizedBox(height: ScreenSize.height * 0.016),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: ColorGuid.surfaceColor,
        highlightColor: ColorGuid.glassBorder,
        child: Container(
          height: ScreenSize.height * 0.14,
          decoration: BoxDecoration(
            color: ColorGuid.surfaceColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
