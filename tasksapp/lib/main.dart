import 'package:flutter/material.dart';
import 'package:tasksapp/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 51, 255),
        ),
        useMaterial3: true, // Enable Material 3 design
      ),
      debugShowMaterialGrid: false,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
