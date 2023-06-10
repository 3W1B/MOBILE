import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/pages/readings/readings_page.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_appbar.dart';

import '../../models/logger.dart';
import '../../models/user.dart';
import '../../repositories/logger_repository.dart';
import '../../repositories/user_logger_repository.dart';
import 'device_widget.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key, required this.user, this.loggers});

  final User user;
  final List<Logger>? loggers;

  Future addLogger(
      TextEditingController loggerIdController,
      TextEditingController loggerPasswordController,
      ValueNotifier<List<Logger>> loggers) async {
    final userLoggerRepository = UserLoggerRepository();
    final userLogger = await userLoggerRepository.create(
        user.id, loggerIdController.text, loggerPasswordController.text);
    final loggerRepository = LoggerRepository();
    final logger = await loggerRepository.read(userLogger.loggerId);
    loggers.value = [...loggers.value, logger];
  }

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (BuildContext context) {
        final loggers = useState<List<Logger>>(this.loggers ?? []);

        final loggerIdController = useTextEditingController();
        final loggerPasswordController = useTextEditingController();

        return Scaffold(
          appBar: FooAppbar(context: context, title: 'Devices'),
          body: Column(
            children: [
              if (loggers.value.isEmpty) ...[
                const Text("No loggers found"),
              ] else ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: loggers.value.length,
                      itemBuilder: (context, index) {
                        return DeviceWidget(
                          logger: loggers.value[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  loggerId: loggers.value[index].id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: loggerIdController,
                      decoration: const InputDecoration(
                        labelText: 'Logger ID',
                      ),
                    ),
                    TextField(
                      controller: loggerPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Logger password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            await addLogger(loggerIdController,
                                loggerPasswordController, loggers);
                          },
                          child: const AsapText(text: "Add logger")),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
