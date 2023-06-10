import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/interfaces/graph.dart';
import 'package:radon_app/models/log.dart';
import 'package:radon_app/utils/app_colors.dart';
import 'package:radon_app/widgets/chart_legend.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/foo_line_chart.dart';

class RadonGraph extends HookWidget implements Graph {
  const RadonGraph({super.key, required this.logs});

  final List<Log> logs;

  List<FlSpot> getStaSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.radonSta.toDouble()));
    }
    return spots;
  }

  List<FlSpot> getLtaSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.radonLta.toDouble()));
    }
    return spots;
  }

  @override
  double getMaxY() {
    var maxY = 0.0;
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final logInside = log.logInsides.first;
      if (logInside.radonSta > maxY) {
        maxY = logInside.radonSta.toDouble();
      }
      if (logInside.radonLta > maxY) {
        maxY = logInside.radonLta.toDouble();
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
      if (logInside.radonSta < minY) {
        minY = logInside.radonSta.toDouble();
      }
      if (logInside.radonLta < minY) {
        minY = logInside.radonLta.toDouble();
      }
    }
    return minY;
  }

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: 'Radon',
      titleIcon: Icons.waves_rounded,
      titleColor: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          FooLineChart(
            legend: Legend(
              labels: ['Short Average', 'Long Average'],
              colors: [AppColors.radonSta, AppColors.radonLta],
            ),
            description: 'Measured in Bq/m3',
            minX: 0,
            maxX: logs.length.toDouble() - 1,
            minY: getMinY(),
            maxY: getMaxY(),
            lineBarsData: [
              LineChartBarData(
                spots: getLtaSpots(),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.radonLta.withOpacity(0.3),
                ),
                color: AppColors.radonLta,
              ),
              LineChartBarData(
                spots: getStaSpots(),
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.radonSta.withOpacity(0.3),
                ),
                color: AppColors.radonSta,
              ),
            ],
            interval: 20,
          ),
        ],
      ),
    );
  }
}
