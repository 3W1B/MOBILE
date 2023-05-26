import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/pages/foo_page.dart';
import 'package:radon_app/repositories/user_repository.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              ElevatedButton(onPressed: () async {

                final userRepository = UserRepository();
                final user = await userRepository.login(
                  emailController.text, passwordController.text,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FooPage(user: user)
                  ),
                );
              }, child: Text("Login")),
              GestureDetector(
                child: Text("Don't have an account?"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RegisterScreen()
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HookBuilder(
        builder: (context){
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
              ElevatedButton(onPressed: () async {

                  final userRepository = UserRepository();
                  await userRepository.register(
                    emailController.text, passwordController.text,
                    firstNameController.text, lastNameController.text,
                    phoneController.text
                  );

                  Navigator.pop(context);

              }, child: Text("Register")),
              GestureDetector(
                child: Text("Already have an account?"),
                onTap: () {
                  // go back to login page
                  Navigator.pop(context);
                },
              ),

            ],
          )
      );
    } );


  }
  
  
}