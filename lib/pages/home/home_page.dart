import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/pages/home/map_widget.dart';
import 'package:radon_app/pages/home/stats_widget.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, required this.selectedLogger});

  final Logger selectedLogger;

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Device ${selectedLogger.id}'),
      ),
      body: Center(
        child: IndexedStack(
          index: bottomNavIndex.value,
          children: [
            StatsWidget(logger: selectedLogger),
            MapWidget(logger: selectedLogger),
          ],
        ),
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
        ],
        currentIndex: bottomNavIndex.value,
        selectedItemColor: Colors.green[800],
        onTap: (int index) {
          bottomNavIndex.value = index;
        },
      ),
    );
  }
}
