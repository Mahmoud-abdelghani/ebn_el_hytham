// lib/features/materials/presentation/widgets/materials_shimmer_loading.dart

import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MaterialsShimmerLoading extends StatelessWidget {
  const MaterialsShimmerLoading({super.key});

  static const int _itemCount = 7;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: ScreenSize.height * 0.012),
      itemCount: _itemCount,
      separatorBuilder: (_, __) => SizedBox(height: ScreenSize.height * 0.006),
      itemBuilder: (context, index) => _ShimmerMaterialTile(index: index),
    );
  }
}

class _ShimmerMaterialTile extends StatelessWidget {
  const _ShimmerMaterialTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      child: Shimmer.fromColors(
        baseColor: context.surface,
        highlightColor: context.accent.withOpacity(0.15),
        period: const Duration(milliseconds: 1200),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.045,
            vertical: ScreenSize.height * 0.022,
          ),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(
                width: ScreenSize.width * (0.35 + (index % 3) * 0.07),
                height: 16,
                borderRadius: 6,
              ),
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
        color: context.onBackground.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
