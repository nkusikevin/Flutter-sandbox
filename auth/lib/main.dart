import 'package:auth/auth_middleware.dart';
import 'package:flutter/material.dart';

//frebase related imports
import 'package:firebase_core/firebase_core.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'firebase_options.dart';
import 'package:auth/components/snackBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (isFirstTime) {
            isFirstTime = false;
            break;
          }
          print('Connected');
          break;
        case InternetConnectionStatus.disconnected:
          print('Disconnected');
          break;
      }
    });
  }

  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Authentify',
        debugShowCheckedModeBanner: false,
        home: AuthPage());
  }
}
