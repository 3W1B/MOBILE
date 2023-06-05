import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Legend {
  final List<String> labels;
  final List<Color> colors;

  Legend({required this.labels, required this.colors});
}

class ChartLegend extends HookWidget {
  const ChartLegend({super.key, required this.legend});

  final Legend legend;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < legend.labels.length; i++)
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: legend.colors[i],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Text(legend.labels[i]),
            ],
          ),
      ],
    );
  }

}