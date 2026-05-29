// lib/features/materials/presentation/widgets/materials_shimmer_loading.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';

class MaterialsShimmerLoading extends StatelessWidget {
  const MaterialsShimmerLoading({super.key});

  // عدد الـ items اللي هتظهر في اللودينج
  static const int _itemCount = 7;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
      itemCount: _itemCount,
      separatorBuilder: (_, __) => SizedBox(height: ScreenSize.height * 0.006),
      itemBuilder: (context, index) => const _ShimmerMaterialTile(),
    );
  }
}

class _ShimmerMaterialTile extends StatelessWidget {
  const _ShimmerMaterialTile();

  @override
  Widget build(BuildContext context) {
    // نفس الـ padding بتاع CustomMaterialContainer
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      child: Shimmer.fromColors(
        // baseColor يتماشى مع الـ dark background
        baseColor: const Color(0xFF1E1E1E),
        // highlightColor فيه لمسة ذهبية خفيفة تتناسب مع الـ golden accent
        highlightColor: const Color(0xFF3A3218),
        period: const Duration(milliseconds: 1200),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.045,
            vertical: ScreenSize.height * 0.022,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // اسم المادة placeholder - بيتغير عرضه عشان يبدو طبيعي
              _ShimmerBox(
                width: ScreenSize.width * (0.35 + (index % 3) * 0.07),
                height: 16,
                borderRadius: 6,
              ),
              // زرار "Show" placeholder
              _ShimmerBox(
                width: ScreenSize.width * 0.1,
                height: 14,
                borderRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  int get index => 0;
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
