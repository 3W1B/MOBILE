import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/repositories/user_repository.dart';
import 'package:radon_app/widgets/asap_text.dart';
import 'package:radon_app/widgets/foo_appbar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final emailController = useTextEditingController();
      final passwordController = useTextEditingController();
      final firstNameController = useTextEditingController();
      final lastNameController = useTextEditingController();
      final phoneController = useTextEditingController();
      return Scaffold(
          appBar: FooAppbar(context: context, title: 'Register'),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        final userRepository = UserRepository();
                        await userRepository.register(
                            emailController.text,
                            passwordController.text,
                            firstNameController.text,
                            lastNameController.text,
                            phoneController.text);

                        Navigator.pop(context);
                      },
                      child: const AsapText(text: "Register")),
                ),
                GestureDetector(
                  child: const AsapText(text: "Already have an account?"),
                  onTap: () {
                    // go back to login page
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ));
    });
  }
}
