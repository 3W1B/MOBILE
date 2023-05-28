import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';

class DevicesWidget extends HookWidget {
  const DevicesWidget({super.key, required this.logger});

  final Logger? logger;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Devices"),
    );
  }
}
