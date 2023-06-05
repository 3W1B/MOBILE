import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/utils/json_file_manager.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_container.dart';

import '../../models/logger.dart';

class DeviceWidget extends HookWidget {
  const DeviceWidget({super.key, required this.logger, required this.onTap});

  final Logger logger;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FooContainer(
      title: logger.id,
      titleIcon: Icons.sensors,
      titleColor: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onTap,
                  child: Icon(
                    Icons.remove_red_eye_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
              ),),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await JsonFileManager.read(logger.id) != null) {
                      JsonFileManager.update({logger.id: "kakao"});
                    } else {
                      await JsonFileManager.create({logger.id: "kakao"});
                    }
                  },
                  child: Icon(
                    Icons.edit_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
