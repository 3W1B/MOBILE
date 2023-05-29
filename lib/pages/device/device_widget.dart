import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/logger.dart';

class DeviceWidget extends HookWidget {
  const DeviceWidget(
      {super.key, required this.logger, required this.onTap, this.isSelected});

  final Logger logger;
  final VoidCallback onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(logger.id),
        if (isSelected == true) ...[
          const Icon(Icons.check_circle_outline_rounded),
        ] else ...[
          ElevatedButton(
              onPressed: () {
                onTap();
              },
              child: const Icon(Icons.add_circle_outline_rounded)),
        ]
      ],
    );
  }
}
