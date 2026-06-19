import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GaussianChart extends StatelessWidget {
  final double mu;
  final double sigma;
  final List<FlSpot> spots;
  final double progress;

  const GaussianChart({
    super.key,
    required this.mu,
    required this.sigma,
    required this.spots,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final peak = spots.isEmpty
        ? 0.01
        : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);

    return Container(
      height: ScreenSize.height * 0.28,
      padding: EdgeInsets.all(ScreenSize.width * 0.035),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: LineChart(
        LineChartData(
          backgroundColor: context.surface,
          minX: 0,
          maxX: 100,
          minY: 0,
          maxY: peak * 1.3 * progress,
          clipData: const FlClipData.all(),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: context.divider, strokeWidth: 0.5),
            getDrawingVerticalLine: (_) =>
                FlLine(color: context.divider, strokeWidth: 0.5),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: context.cardBorder),
          ),
          titlesData: FlTitlesData(
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                getTitlesWidget: (v, _) => Text(
                  v.toInt().toString(),
                  style: TextStyle(
                      color: context.textMuted,
                      fontSize: ScreenSize.height * 0.011),
                ),
              ),
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              color: context.accent,
              spots: spots
                  .map((s) => FlSpot(s.x, s.y * progress))
                  .toList(),
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: context.accent.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
