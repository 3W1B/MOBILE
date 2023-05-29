import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/log_inside.dart';
import 'package:radon_app/models/log_outside.dart';
import 'package:radon_app/widgets/foo_container.dart';

class TemperatureWidget extends HookWidget {
  const TemperatureWidget(
      {super.key, required this.logInside, required this.logOutside});

  final LogInside logInside;
  final LogOutside logOutside;

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: "Temperature",
      titleIcon: Icons.abc,
      titleColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          FooContainer(
            title: "Inside",
            titleIcon: Icons.monitor_heart_rounded,
            titleColor: Colors.white,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.white,
            body: Text(
              "${logInside.temperature}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          FooContainer(
            title: "Outside",
            titleIcon: Icons.shield,
            titleColor: Colors.white,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.white,
            body: Text("${logOutside.temperature}",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
