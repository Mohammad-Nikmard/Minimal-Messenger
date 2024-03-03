import 'package:flutter/material.dart';
import 'package:minimal_messenger/DI/service_locator.dart';
import 'package:minimal_messenger/services/auth/auth_service.dart';
import 'package:minimal_messenger/widgets/my_button.dart';
import 'package:minimal_messenger/widgets/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.callBack});
  final VoidCallback callBack;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final user = AuthServices(locator.get(), locator.get());
  Future<void> signUp(
      String email, String password, String passwordConfirm) async {
    if (password == passwordConfirm) {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        await user.signUp(email, password);
        if (!mounted) return;
        Navigator.pop(context);
      } on Exception catch (ex) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(ex.toString()),
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Passwords dont' match"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var pwConfirmController = TextEditingController();
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
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hint: "Password",
                obsecure: true,
                controller: passwordController,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                hint: "Confirm Password",
                obsecure: true,
                controller: pwConfirmController,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                text: "Register",
                onTap: () async {
                  await signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    pwConfirmController.text.trim(),
                  );
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.callBack,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
