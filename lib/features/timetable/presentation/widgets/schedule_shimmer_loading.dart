// lib/features/materials/presentation/widgets/schedule_shimmer_loading.dart

import 'package:ebn_el_hytham/core/utils/color_guid.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScheduleShimmerLoading extends StatelessWidget {
  const ScheduleShimmerLoading({super.key});

  static const int _periodsCount = 6;
  static const int _daysCount = 6;
  static const double _colWidth = 100;
  static const double _periodColWidth = 55;
  static const double _cellHeight = 72;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(ScreenSize.width * 0.03),
      child: Column(
        children: [
          // ── Legend Shimmer ────────────────────────────────────
          _ShimmerLegend(),
          SizedBox(height: ScreenSize.height * 0.018),

          // ── Table Shimmer ─────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: _periodColWidth + (_daysCount * _colWidth),
              child: Column(
                children: [
                  // Header row
                  _ShimmerHeaderRow(),
                  // Period rows
                  ...List.generate(
                    _periodsCount,
                    (i) => _ShimmerPeriodRow(periodIndex: i),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shimmer Legend ────────────────────────────────────────────────────────────
class _ShimmerLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E1E1E),
      highlightColor: const Color(0xFF3A3218),
      period: const Duration(milliseconds: 1200),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(ScreenSize.width * 0.04),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          spacing: 10,
          runSpacing: 8,
          children: List.generate(4, (i) {
            // عروض متفاوتة تبدو طبيعية
            final widths = [80.0, 110.0, 70.0, 95.0];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: widths[i],
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ── Shimmer Header Row ────────────────────────────────────────────────────────
class _ShimmerHeaderRow extends StatelessWidget {
  static const double _colWidth = 100;
  static const double _periodColWidth = 55;
  static const int _daysCount = 6;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1A1A2E),
      highlightColor: const Color(0xFF2A2A3E),
      period: const Duration(milliseconds: 1200),
      child: Container(
        decoration: const BoxDecoration(color: Color(0xFF1A1A2E)),
        child: Row(
          children: [
            // خلية فاضية فوق الفترات
            SizedBox(width: _periodColWidth, height: 40),
            ...List.generate(_daysCount, (_) {
              return Container(
                width: _colWidth,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.white10)),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 28,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Shimmer Period Row ────────────────────────────────────────────────────────
class _ShimmerPeriodRow extends StatelessWidget {
  final int periodIndex;

  const _ShimmerPeriodRow({required this.periodIndex});

  static const double _colWidth = 100;
  static const double _periodColWidth = 55;
  static const double _cellHeight = 72;
  static const int _daysCount = 6;

  // نسبة الخلايا اللي هتكون فيها مادة (عشوائية بس ثابتة عشان تبدو واقعية)
  static const List<List<bool>> _filledPattern = [
    [true, false, false, true, false, false],
    [false, true, false, false, true, false],
    [false, false, true, false, false, true],
    [true, false, false, false, true, false],
    [false, true, false, true, false, false],
    [false, false, false, false, false, true],
  ];

  @override
  Widget build(BuildContext context) {
    final pattern = _filledPattern[periodIndex % _filledPattern.length];

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // خلية الفترة
          Shimmer.fromColors(
            baseColor: const Color(0xFF1A1A2E),
            highlightColor: const Color(0xFF2A2A3E),
            period: const Duration(milliseconds: 1200),
            child: Container(
              width: _periodColWidth,
              height: _cellHeight,
              color: const Color(0xFF1A1A2E),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 34,
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // خلايا الأيام
          ...List.generate(_daysCount, (dayIndex) {
            final isFilled = pattern[dayIndex];
            return Container(
              width: _colWidth,
              height: _cellHeight,
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.white10)),
              ),
              padding: const EdgeInsets.all(3),
              child: isFilled
                  ? Shimmer.fromColors(
                      baseColor: const Color(0xFF1E1E2E),
                      highlightColor: const Color(0xFF3A3218),
                      period: Duration(milliseconds: 1200 + (dayIndex * 80)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E2E),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white12, width: 1),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 65,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 40,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          }),
        ],
      ),
    );
  }
}
