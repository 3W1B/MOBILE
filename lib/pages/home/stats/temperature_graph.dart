import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/foo_line_chart.dart';

class TemperatureGraph extends HookWidget {
  const TemperatureGraph({super.key, required this.logger});

  final Logger logger;

  List<FlSpot> getInsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.temperature.toDouble()));
    }
    return spots;
  }

  List<FlSpot> getOutsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
      final logOutside = log.logOutsides.first;
      spots.add(FlSpot(i.toDouble(), logOutside.temperature.toDouble()));
    }
    return spots;
  }

  double getMaxY() {
    var maxY = 0.0;
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
      final logInside = log.logInsides.first;
      final logOutside = log.logOutsides.first;
      if (logInside.temperature > maxY) {
        maxY = logInside.temperature.toDouble();
      }
      if (logOutside.temperature > maxY) {
        maxY = logOutside.temperature.toDouble();
      }
    }
    return maxY;
  }

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: 'Temperature',
      titleIcon: Icons.wb_sunny,
      titleColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Colors.white,
      child: FooLineChart(
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
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        minX: 0,
        maxX: logger.logs.length.toDouble() - 1,
        minY: 0,
        maxY: getMaxY(),
        lineBarsData: [
          LineChartBarData(
            spots: getInsideSpots(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
          LineChartBarData(
            spots: getOutsideSpots(),
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}