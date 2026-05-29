import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeadingShimmer extends StatelessWidget {
  const HomeHeadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorGuid.surfaceColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + ScreenSize.height * 0.02,
        left: ScreenSize.width * 0.05,
        right: ScreenSize.width * 0.05,
        bottom: ScreenSize.height * 0.03,
      ),
      child: Shimmer.fromColors(
        baseColor: ColorGuid.surfaceColor,
        highlightColor: ColorGuid.amber.withOpacity(0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row: avatar + pill + bell ──────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Avatar circle
                _ShimmerBox(
                  width: ScreenSize.height * 0.066,
                  height: ScreenSize.height * 0.066,
                  borderRadius: 999,
                ),
                // Faculty pill
                _ShimmerBox(
                  width: ScreenSize.width * 0.42,
                  height: ScreenSize.height * 0.034,
                  borderRadius: 20,
                ),
                // Bell icon placeholder
                _ShimmerBox(
                  width: ScreenSize.height * 0.044,
                  height: ScreenSize.height * 0.044,
                  borderRadius: 8,
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.022),

            // ── "Welcome back" line ────────────────────────────────
            _ShimmerBox(
              width: ScreenSize.width * 0.3,
              height: ScreenSize.height * 0.016,
              borderRadius: 6,
            ),
            SizedBox(height: ScreenSize.height * 0.012),

            // ── Name line ─────────────────────────────────────────
            _ShimmerBox(
              width: ScreenSize.width * 0.55,
              height: ScreenSize.height * 0.026,
              borderRadius: 6,
            ),
            SizedBox(height: ScreenSize.height * 0.014),

            // ── ID + Email pills row ───────────────────────────────
            Row(
              children: [
                _ShimmerBox(
                  width: ScreenSize.width * 0.28,
                  height: ScreenSize.height * 0.018,
                  borderRadius: 6,
                ),
                SizedBox(width: ScreenSize.width * 0.03),
                _ShimmerBox(
                  width: ScreenSize.width * 0.42,
                  height: ScreenSize.height * 0.018,
                  borderRadius: 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable grey box used as shimmer placeholder
class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // slightly lighter than surface so shimmer sweep is visible
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}