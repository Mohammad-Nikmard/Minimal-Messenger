import 'package:flutter/material.dart';
import 'package:minimal_messenger/ui/login_screen.dart';
import 'package:minimal_messenger/ui/register_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool toggled = false;
  void onToggle() {
    setState(() {
      toggled = !toggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggled) {
      return RegisterScreen(
        callBack: onToggle,
      );
    } else {
      return LoginScreen(
        callBack: onToggle,
      );
    }
  }
}
