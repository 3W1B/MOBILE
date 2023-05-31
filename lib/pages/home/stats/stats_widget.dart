import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/home/stats/humidity_graph.dart';
import 'package:radon_app/pages/home/stats/radon_graph.dart';
import 'package:radon_app/pages/home/stats/temperature_graph.dart';

class StatsWidget extends HookWidget {
  const StatsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: GraphsWidget(logger: logger));
  }
}

class GraphsWidget extends HookWidget {
  const GraphsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadonGraph(logger: logger),
        HumidityGraph(logger: logger),
        TemperatureGraph(logger: logger),
      ],
    );
  }
}
