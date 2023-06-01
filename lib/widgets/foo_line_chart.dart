import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/widgets/chart_legend.dart';

class FooLineChart extends HookWidget {
  const FooLineChart(
      {super.key,
      required this.legend,
        required this.description,
      required this.minX,
      required this.maxX,
      required this.minY,
      required this.maxY,
      required this.lineBarsData,
        required this.interval,
      });

  final Legend legend;
  final String description;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final List<LineChartBarData> lineBarsData;
  final double interval;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: Column(
        children: [
          ChartLegend(legend: legend),
          SizedBox(
            height: 125,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  verticalInterval: interval / 2,
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, titleMeta) {
                        if (value == titleMeta.max) {
                          return Container();
                        }
                        return Text(
                          '${value.toInt()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                      interval: interval,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: minX,
                maxX: maxX,
                minY: minY,
                maxY: maxY,
                lineBarsData: lineBarsData,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
