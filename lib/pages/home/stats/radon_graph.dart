import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/foo_line_chart.dart';

class RadonGraph extends HookWidget {
  const RadonGraph({super.key, required this.logger});

  final Logger logger;

  List<FlSpot> getStaSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.radonSta.toDouble()));
    }
    return spots;
  }

  List<FlSpot> getLtaSpots() {
    final spots = <FlSpot>[];
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
      final logInside = log.logInsides.first;
      spots.add(FlSpot(i.toDouble(), logInside.radonLta.toDouble()));
    }
    return spots;
  }

  double getMaxY() {
    var maxY = 0.0;
    for (var i = 0; i < logger.logs.length; i++) {
      final log = logger.logs[i];
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
  Widget build(BuildContext context) {
    return FooContainer(
      title: 'Radon',
      titleIcon: Icons.show_chart,
      titleColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Text('Lta'),
              SizedBox(width: 40),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Text('Sta'),
            ],
          ),
          FooLineChart(
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
              border: Border.all(color: Colors.black, width: 1),
            ),
            minX: 0,
            maxX: logger.logs.length.toDouble() - 1,
            minY: 0,
            maxY: getMaxY(),
            lineBarsData: [
              LineChartBarData(
                spots: getLtaSpots(),
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
                spots: getStaSpots(),
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
        ],
      ),
    );
  }
}
