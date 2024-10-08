import 'package:flutter/material.dart';
import 'package:food_order/auth/login_or_register.dart';
import 'package:food_order/model/restaurant.dart';
import 'package:food_order/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => Restaurant()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void onSignUp() {
    print("Sign Up");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const LoginOrRegister());
  }
}
