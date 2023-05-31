import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/log_inside.dart';
import 'package:radon_app/widgets/foo_container.dart';

class RadonWidget extends HookWidget {
  const RadonWidget({super.key, required this.logInside});

  final LogInside logInside;

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: "Radon",
      titleIcon: Icons.error_rounded,
      titleColor: Colors.black,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          FooContainer(
            title: "Reading",
            titleIcon: Icons.monitor_heart_rounded,
            titleColor: Colors.white,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.black,
            body: Column(
              children: [
                Text("${logInside.radonSta}",
                    style: TextStyle(color: Colors.white)),
                Text("${logInside.radonLta}",
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          FooContainer(
            title: "Status",
            titleIcon: Icons.shield,
            titleColor: Colors.white,
            borderRadius: BorderRadius.circular(30),
            backgroundColor: Colors.black,
            body: Text("Good", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
