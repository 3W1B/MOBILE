import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/utils/json_file_manager.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_container.dart';
import 'package:radon_app/widgets/popup.dart';

import '../../models/logger.dart';

class DeviceWidget extends HookWidget {
  const DeviceWidget({super.key, required this.logger, required this.onTap});

  final Logger logger;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final deviceName = useState<String>(logger.id);

    useEffect(() {
      JsonFileManager.read(logger.id).then(
        (value) {
          if (value != null) {
            deviceName.value = value;
          }
        },
      );
      return null;
    }, []);

    return FooContainer(
      title: deviceName.value,
      titleIcon: Icons.sensors,
      titleColor: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(30),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (logger.id != deviceName.value)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AsapText(
                  text: 'Device id: ${logger.id}',
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
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
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupHookWidget(
                          onConfirm: (String enteredText) async {
                            if (enteredText.isNotEmpty) {
                              if (await JsonFileManager.read(logger.id) !=
                                  null) {
                                await JsonFileManager.update(
                                    {logger.id: enteredText});
                              } else {
                                await JsonFileManager.create(
                                    {logger.id: enteredText});
                              }
                            }
                            deviceName.value = enteredText;
                          },
                          title: 'Edit device name',
                        );
                      },
                    );
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
