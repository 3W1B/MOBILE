import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/home/stats/humidity_widget.dart';
import 'package:radon_app/pages/home/stats/radon_widget.dart';
import 'package:radon_app/pages/home/stats/temperature_widget.dart';

class StatsWidget extends HookWidget {
  const StatsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  selectedIndex.value = 0;
                },
                child: Text("Cards")),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: () {
                  selectedIndex.value = 1;
                },
                child: Text("Graphs")),
          ],
        ),
        IndexedStack(
          index: selectedIndex.value,
          children: [
            CardsWidget(logger: logger),
            GraphsWidget(logger: logger),
          ],
        ),
      ],
    );
  }
}

class CardsWidget extends HookWidget {
  const CardsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    final logInside = logger.logs.first.logInsides.first;
    final logOutside = logger.logs.first.logOutsides.first;
    return Column(
      children: [
        RadonWidget(logInside: logInside),
        HumidityWidget(logInside: logInside, logOutside: logOutside),
        TemperatureWidget(logInside: logInside, logOutside: logOutside),
      ],
    );
  }
}

class GraphsWidget extends HookWidget {
  const GraphsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Graph"),
      ],
    );
  }
}
