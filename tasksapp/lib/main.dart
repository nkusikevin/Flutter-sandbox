import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasksapp/home_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();

  var box = await Hive.openBox('tasks');

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
