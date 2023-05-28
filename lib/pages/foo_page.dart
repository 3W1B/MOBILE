import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:radon_app/models/logger.dart';
import 'package:radon_app/models/user.dart';
import 'package:radon_app/widget/devices.dart';
import 'package:radon_app/widget/g_maps.dart';
import 'package:radon_app/widget/stats.dart';

class FooPage extends StatefulHookWidget {
  const FooPage({super.key, required this.user});

  final User user;

  @override
  // ignore: library_private_types_in_public_api
  _FooPageState createState() => _FooPageState();
}

class _FooPageState extends State<FooPage> {
  int _selectedIndex = 0;

  // SHOULD BE CHANGED TO A REAL LOGGER
  static get logger => Logger.fromJson(jsonDecode(
      '{"id": 1, "name": "test", "locations": [{"id": 1, "latitude": 55.000065, "longitude": 9.4337785, "loggerId": 1, "createdAt": "2021-10-17T20:00:00.000Z", "updatedAt": "2021-10-17T20:00:00.000Z"}], "createdAt": "2021-10-17T20:00:00.000Z"}'));

  final List<Widget> _widgetOptions = <Widget>[
    StatsWidget(logger: logger),
    GoogleMapsWidget(logger: logger),
    DevisesWidget(logger: logger),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
