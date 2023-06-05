import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/interfaces/graph.dart';
import 'package:radon_app/models/log.dart';
import 'package:radon_app/utils/app_colors.dart';
import 'package:radon_app/widgets/chart_legend.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/foo_line_chart.dart';

class TemperatureGraph extends HookWidget implements Graph {
  const TemperatureGraph({super.key, required this.logs});

  final List<Log> logs;

  List<FlSpot> getInsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.temperature.toDouble()));
    }
    return spots;
  }

  List<FlSpot> getOutsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logOutside = log.logOutsides.first;
      spots.add(FlSpot(i.toDouble(), logOutside.temperature.toDouble()));
    }
    return spots;
  }

  @override
  double getMaxY() {
    var maxY = 0.0;
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
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
  double getMinY() {
    var minY = 100.0;
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      final logOutside = log.logOutsides.first;
      if (logInside.temperature < minY) {
        minY = logInside.temperature.toDouble();
      }
      if (logOutside.temperature < minY) {
        minY = logOutside.temperature.toDouble();
      }
    }
    return minY;
  }

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: 'Temperature',
      titleIcon: Icons.thermostat_rounded,
      titleColor: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          FooLineChart(
            legend: Legend(
              labels: ['Inside', 'Outside'],
              colors: [
                AppColors.temperatureInside,
                AppColors.temperatureOutside
              ],
            ),
            description: 'Measured in °C',
            minX: 0,
            maxX: logs.length.toDouble() - 1,
            minY: getMinY(),
            maxY: getMaxY(),
            lineBarsData: [
              LineChartBarData(
                spots: getOutsideSpots(),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.temperatureOutside.withOpacity(0.3),
                ),
                color: AppColors.temperatureOutside,
              ),
              LineChartBarData(
                spots: getInsideSpots(),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.temperatureInside.withOpacity(0.3),
                ),
                color: AppColors.temperatureInside,
              ),
            ],
            interval: 2,
          ),
        ],
      ),
    );
  }
}
