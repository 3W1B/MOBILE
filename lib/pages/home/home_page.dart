import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/models/user.dart';
import 'package:radon_app/pages/home/devices_widget.dart';
import 'package:radon_app/pages/home/map_widget.dart';
import 'package:radon_app/pages/home/stats_widget.dart';
import 'package:radon_app/repositories/logger_repository.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, required this.user});

  final User user;

  static get testLogger => Logger.fromJson({
        "id": "asd",
        "password": "asd",
        "locations": [
          {
            "id": 1,
            "loggerId": "asd",
            "latitude": 55.000065,
            "longitude": 9.4337785,
          }
        ],
        "logs": [
          {
            "id": 1,
            "loggerId": "asd",
            "timestamp": "2021-10-17T20:00:00.000Z",
            "logInsides": [
              {
                "id": 1,
                "logId": 1,
                "temperature": 20,
                "humidity": 20,
                "radonLta": 20,
                "radonSta": 20,
              },
            ],
            "logOutsides": [
              {
                "id": 1,
                "logId": 1,
                "temperature": 20,
                "humidity": 20,
              }
            ]
          },
        ],
      });

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    final loggers = List<Logger>.empty(growable: true);

    final loggerRepository = LoggerRepository();
    user.userLoggers.forEach((userLogger) async {
      final logger = await loggerRepository.read(userLogger.loggerId);
      loggers.add(logger);
    });

    final widgets = [
      StatsWidget(logger: testLogger),
      MapWidget(logger: testLogger),
      DevicesWidget(loggers: loggers),
    ];

    return Scaffold(
      body: Center(
        child: widgets.elementAt(index.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: 'Devices',
          ),
        ],
        currentIndex: index.value,
        selectedItemColor: Colors.green[800],
        onTap: (int i) {
          index.value = i;
        },
      ),
    );
  }
}
