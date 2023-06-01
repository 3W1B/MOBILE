import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/pages/device/device_page.dart';
import 'package:radon_app/pages/login/register_page.dart';
import 'package:radon_app/repositories/user_repository.dart';

import '../../models/logger.dart';
import '../../models/user_logger.dart';
import '../../repositories/logger_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<List<Logger>> fetchLoggers(List<UserLogger> userLoggers) async {
    final loggerRepository = LoggerRepository();
    List<Logger> loggers = [];
    for (var userLogger in userLoggers) {
      final logger = await loggerRepository.read(userLogger.loggerId);
      loggers.add(logger);
    }
    return loggers;
  }

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final emailController = useTextEditingController();
        final passwordController = useTextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Column(
            children: [
              Text("email"),
              TextField(
                controller: emailController,
              ),
              Text("password"),
              TextField(
                controller: passwordController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final userRepository = UserRepository();
                    final user = await userRepository.login(
                      emailController.text,
                      passwordController.text,
                    );
                    final loggers = await fetchLoggers(user.userLoggers);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              DevicePage(user: user, loggers: loggers),
                      ),
                    );
                  },
                  child: Text("Login")),
              GestureDetector(
                child: Text("Don't have an account?"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
