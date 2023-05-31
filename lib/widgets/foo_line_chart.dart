import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FooLineChart extends HookWidget {
  const FooLineChart({super.key,
    required this.titlesData,
    required this.borderData,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.lineBarsData});

  final FlTitlesData titlesData;
  final FlBorderData borderData;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final List<LineChartBarData> lineBarsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 175,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: false,
            ),
            titlesData: titlesData,
            borderData: borderData,
            minX: minX,
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            lineBarsData: lineBarsData,
          )
        ),
      ),
    );
  }
}
