import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/readings/map_widget.dart';
import 'package:radon_app/pages/readings/graphs/graphs_widget.dart';
import 'package:radon_app/repositories/logger_repository.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_appbar.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, required this.loggerId});

  final String loggerId;

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = useState(0);

    final loggerRepository = LoggerRepository();
    final loggerState = useState<Logger?>(null);

    useEffect(() {
      if (loggerState.value == null) {
        debugPrint('${DateTime.now()} - Initial logger read');
        loggerRepository.read(loggerId).then((logger) {
          loggerState.value = logger;
        });
      }
      Timer? timer;
      debugPrint('${DateTime.now()} - Starting timer');
      timer = Timer.periodic(const Duration(minutes: 15), (_) async {
        debugPrint('${DateTime.now()} - Updating logger');
        final logger = await loggerRepository.read(loggerId);
        loggerState.value = logger;
      });

      return () {
        debugPrint('${DateTime.now()} - Cancelling timer');
        timer?.cancel();
        timer = null;
      };
    }, []);

    return loggerState.value == null
        ? const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 20),
                Center(child: AsapText(text: 'Loading data...')),
              ],
            )
          )
        : Scaffold(
            appBar: FooAppbar(context: context, title: 'Readings'),
            body: IndexedStack(
              index: bottomNavIndex.value,
              children: [
                SingleChildScrollView(
                    child: GraphsWidget(logger: loggerState.value!)),
                MapWidget(logger: loggerState.value!),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.poll_outlined),
                  label: 'Graphs',
                  activeIcon: Icon(Icons.poll_rounded),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined),
                  label: 'Map',
                  activeIcon: Icon(Icons.location_on),
                ),
              ],
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Asap'),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal, fontFamily: 'Asap'),
              currentIndex: bottomNavIndex.value,
              onTap: (int index) {
                bottomNavIndex.value = index;
              },
            ),
          );
  }
}
