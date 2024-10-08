import 'package:flutter/material.dart';
import 'package:food_order/pages/login_page.dart';
import 'package:food_order/pages/register_page.dart';
import 'package:food_order/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
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
        home: RegisterPage(onTap: onSignUp));
  }
}
