import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_messenger/DI/service_locator.dart';
import 'package:minimal_messenger/bloc/theme_bloc.dart';
import 'package:minimal_messenger/bloc/theme_state.dart';
import 'package:minimal_messenger/services/auth/auth_gate.dart';
import 'package:minimal_messenger/theme/light_mode.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initSerivceLocator();
  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeInitState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.initTheme,
            home: AuthGate(),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          home: AuthGate(),
        );
      },
    );
  }
}
