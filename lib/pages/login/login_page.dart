import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/pages/home/home_page.dart';
import 'package:radon_app/pages/login/register_page.dart';
import 'package:radon_app/repositories/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
      builder: (context) {
        final emailController = useTextEditingController();
        final passwordController = useTextEditingController();
        return Material(
          child: Column(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage(user: user)),
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
