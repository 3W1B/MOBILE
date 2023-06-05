import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/log.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/home/stats/humidity_graph.dart';
import 'package:radon_app/pages/home/stats/radon_graph.dart';
import 'package:radon_app/pages/home/stats/temperature_graph.dart';
import 'package:radon_app/utils/month_converter.dart';
import 'package:radon_app/widgets/asap_text.dart';

class GraphsWidget extends HookWidget {
  const GraphsWidget({super.key, required this.logger});

  final Logger logger;

  @override
  Widget build(BuildContext context) {
    final selectedLogs = logger.logs
        .where((log) => log.timestamp
            .isAfter(DateTime.now().subtract(const Duration(hours: 24))))
        .toList();
    final filteredLogs = <Log>[];
    for (var i = 0; i < selectedLogs.length; i++) {
      if (i == 0) {
        filteredLogs.add(selectedLogs[i]);
      } else {
        if (selectedLogs[i - 1]
                .timestamp
                .difference(selectedLogs[i].timestamp)
                .inMinutes >=
            30) {
          filteredLogs.add(selectedLogs[i]);
        }
      }
    }

    final timestamp = useState(logger.logs.first.timestamp);
    final formattedTimestamp = "${MonthConverter.convert(timestamp.value.month)} ${timestamp.value.day}, ${timestamp.value.hour}:${timestamp.value.minute.toString().padLeft(2, '0')}";

    return Column(
      children: [
        AsapText(text: "Last updated: $formattedTimestamp"),
        RadonGraph(logs: filteredLogs),
        HumidityGraph(logs: filteredLogs),
        TemperatureGraph(logs: filteredLogs),
      ],
    );
  }
}
