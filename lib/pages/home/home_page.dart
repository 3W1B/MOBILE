import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/home/map_widget.dart';
import 'package:radon_app/pages/home/stats/graphs_widget.dart';
import 'package:radon_app/repositories/logger_repository.dart';
import 'package:radon_app/widgets/foo_appbar.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, required this.selectedLogger});

  final Logger selectedLogger;

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = useState(0);

    final selectedLoggerState = useState<Logger>(selectedLogger);

    useEffect(() {
      Timer.periodic(const Duration(minutes: 15), (timer) async {
        debugPrint('Updating logger data');
        final loggerRepository = LoggerRepository();
        final logger = await loggerRepository.read(selectedLogger.id);
        selectedLoggerState.value = logger;
      });
      return null;
    }, []);

    return Scaffold(
      appBar: FooAppbar(context: context, title: selectedLoggerState.value.id),
      body: IndexedStack(
        index: bottomNavIndex.value,
        children: [
          SingleChildScrollView(child: GraphsWidget(logger: selectedLoggerState.value)),
          MapWidget(logger: selectedLoggerState.value),
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
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Asap'),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Asap'),
        currentIndex: bottomNavIndex.value,
        onTap: (int index) {
          bottomNavIndex.value = index;
        },
      ),
    );
  }
}
