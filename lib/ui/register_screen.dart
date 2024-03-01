import 'package:flutter/material.dart';
import 'package:minimal_messenger/widgets/my_button.dart';
import 'package:minimal_messenger/widgets/my_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();
    var _pwConfirmController = TextEditingController();
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
                "Lest's create an account for you",
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
                height: 10,
              ),
              MyTextField(
                hint: "Confirm Password",
                obsecure: true,
                controller: _pwConfirmController,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Register",
                onTap: () {},
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Login now",
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
