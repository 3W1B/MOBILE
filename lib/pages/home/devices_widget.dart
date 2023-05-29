import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/models/logger.dart';

class DevicesWidget extends HookWidget {
  const DevicesWidget({super.key, required this.loggers});

  final List<Logger> loggers;

  @override
  Widget build(BuildContext context) {
    if (loggers.isEmpty) {
      return const Center(child: Text("No logger found"));
    }
    return Scaffold(
      body: ListView.builder(
        itemCount: loggers!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(loggers![index].id.toString()),
            subtitle: Text("Location: " +
                loggers![index]
                    .locations[loggers![index].locations.length - 1]
                    .latitude
                    .toString() +
                ", " +
                loggers![index]
                    .locations[loggers![index].locations.length - 1]
                    .longitude
                    .toString()),
          );
        },
      ),
    );
  }
}
