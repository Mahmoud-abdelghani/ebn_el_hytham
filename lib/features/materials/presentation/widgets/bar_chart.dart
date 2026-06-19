import 'package:ebn_el_hytham/core/utils/app_theme.dart';
import 'package:ebn_el_hytham/core/utils/screen_size.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> groups;
  const BarChartWidget({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height * 0.26,
      padding: EdgeInsets.all(ScreenSize.width * 0.035),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.glassBorder, width: 1),
      ),
      child: BarChart(
        BarChartData(
          barGroups: groups,
          backgroundColor: context.surface,
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (_) =>
                FlLine(color: context.divider, strokeWidth: 0.5),
            getDrawingVerticalLine: (_) =>
                FlLine(color: Colors.transparent, strokeWidth: 0),
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
                getTitlesWidget: (v, _) {
                  final labels = [
                    '0', '10', '20', '30', '40',
                    '50', '60', '70', '80', '90'
                  ];
                  final i = v.toInt();
                  if (i < 0 || i >= labels.length) return const SizedBox();
                  return Text(
                    labels[i],
                    style: TextStyle(
                        color: context.textMuted,
                        fontSize: ScreenSize.height * 0.011),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}
