import 'package:flutter/material.dart';
import 'package:minimal_messenger/auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthServices().signOut();
          },
          child: const Text("Signout"),
        ),
      ),
    );
  }
}
