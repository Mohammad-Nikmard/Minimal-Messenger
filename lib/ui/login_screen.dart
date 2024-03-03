import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_messenger/DI/service_locator.dart';
import 'package:minimal_messenger/services/auth/auth_service.dart';
import 'package:minimal_messenger/widgets/my_button.dart';
import 'package:minimal_messenger/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.callBack});
  final VoidCallback callBack;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth user = locator.get();

  Future<void> signIn(String email, String password) async {
    final authUser = AuthServices(locator.get(), locator.get());
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await authUser.signIn(email, password);
      if (!mounted) return;
      Navigator.pop(context);
    } on Exception catch (ex) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(ex.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
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
                height: 25,
              ),
              MyButton(
                text: "Login",
                onTap: () async {
                  await signIn(emailController.text.trim(),
                      passwordController.text.trim());
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.callBack,
                    child: Text(
                      "Register now",
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
