import 'package:advanced_todo/pages/setting_pages.dart';
import 'package:advanced_todo/pages/splash_page.dart';
import 'package:advanced_todo/pages/home_page.dart';
import 'package:advanced_todo/pages/create_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:advanced_todo/themes/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/settings': (context) => const SettingsPage(),
        '/create_task': (context) => const CreateTask(),
      },
    );
  }
}
