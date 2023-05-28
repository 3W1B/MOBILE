import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/repositories/user_repository.dart';

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
      return Material(
          child: Column(
        children: [
          Text("First Name"),
          TextField(
            controller: firstNameController,
          ),
          Text("Last Name"),
          TextField(
            controller: lastNameController,
          ),
          Text("Email"),
          TextField(
            controller: emailController,
          ),
          Text("Phone"),
          TextField(
            controller: phoneController,
          ),
          Text("Password"),
          TextField(
            controller: passwordController,
          ),
          ElevatedButton(
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
              child: Text("Register")),
          GestureDetector(
            child: Text("Already have an account?"),
            onTap: () {
              // go back to login page
              Navigator.pop(context);
            },
          ),
        ],
      ));
    });
  }
}
