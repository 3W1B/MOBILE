import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/interfaces/graph.dart';
import 'package:radon_app/models/log.dart';
import 'package:radon_app/utils/app_colors.dart';
import 'package:radon_app/widgets/chart_legend.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/foo_line_chart.dart';

class HumidityGraph extends HookWidget implements Graph {
  const HumidityGraph({super.key, required this.logs});

  final List<Log> logs;

  List<FlSpot> getInsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.humidity.toDouble()));
    }
    return spots;
  }

  List<FlSpot> getOutsideSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logOutside = log.logOutsides.first;
      spots.add(FlSpot(i.toDouble(), logOutside.humidity.toDouble()));
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
      if (logInside.humidity > maxY) {
        maxY = logInside.humidity.toDouble();
      }
      if (logOutside.humidity > maxY) {
        maxY = logOutside.humidity.toDouble();
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
      if (logInside.humidity < minY) {
        minY = logInside.humidity.toDouble();
      }
      if (logOutside.humidity < minY) {
        minY = logOutside.humidity.toDouble();
      }
    }
    return minY;
  }

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: 'Humidity',
      titleIcon: Icons.opacity_rounded,
      titleColor: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          FooLineChart(
            legend: Legend(
              labels: ['Inside', 'Outside'],
              colors: [AppColors.humidityInside, AppColors.humidityOutside],
            ),
            description: 'Measured in %',
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
                  color: AppColors.humidityOutside.withOpacity(0.3),
                ),
                color: AppColors.humidityOutside,
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
                  color: AppColors.humidityInside.withOpacity(0.3),
                ),
                color: AppColors.humidityInside,
              ),
            ],
            interval: 5,
          ),
        ],
      ),
    );
  }
}
