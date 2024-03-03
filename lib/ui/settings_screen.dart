import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_messenger/bloc/theme_bloc.dart';
import 'package:minimal_messenger/bloc/theme_event.dart';
import 'package:minimal_messenger/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchResult = ThemeManager.readTheme();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            switchResult = !switchResult;
          });
          if (switchResult) {
            ThemeManager.saveTheme(true);
          } else {
            ThemeManager.saveTheme(false);
          }
          context.read<ThemeBloc>().add(ThemeDarkedMode());
        },
        child: Container(
          margin: const EdgeInsets.all(25.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              CupertinoSwitch(
                value: switchResult,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
