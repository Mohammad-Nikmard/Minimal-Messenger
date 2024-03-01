import 'package:flutter/material.dart';
import 'package:minimal_messenger/widgets/my_button.dart';
import 'package:minimal_messenger/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Welcome back, You've been missed",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                hint: "Email",
                obsecure: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hint: "Password",
                obsecure: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Login",
                onTap: () {},
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
