import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/pages/device/device_page.dart';
import 'package:radon_app/pages/login/register_page.dart';
import 'package:radon_app/repositories/user_repository.dart';
import 'package:radon_app/utils/user_handler.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_appbar.dart';

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
        final checkBoxValue = useState(false);

        loginFunc(String email, String password) async {
          final userRepository = UserRepository();
          final user = await userRepository.login(
            email,
            password,
          );
          final loggers = await fetchLoggers(user.userLoggers);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DevicePage(user: user, loggers: loggers),
            ),
          );
        }

        useEffect(() {
          UserHandler.getRemembered().then((loginInfo) {
            if (loginInfo != null) {
              loginFunc(loginInfo['email'], loginInfo['password']);
            }
          });
          return null;
        }, []);

        return Scaffold(
          appBar: FooAppbar(context: context, title: 'Login'),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                CheckboxListTile(
                  title: const AsapText(text: "Remember me"),
                  value: checkBoxValue.value,
                  onChanged: (value) {
                    checkBoxValue.value = !checkBoxValue.value;
                    if (!checkBoxValue.value) {
                      UserHandler.logout();
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (checkBoxValue.value) {
                          await UserHandler.remember(email: emailController.text, password: passwordController.text);
                        }
                        await loginFunc(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: const AsapText(text: "Login")),
                ),
                GestureDetector(
                  child: const AsapText(text: "Don't have an account?"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
