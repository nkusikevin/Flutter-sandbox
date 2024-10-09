import 'package:advanced_todo/components/bottom_navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyDone'),
      ),
      // drawer: const SidebarDrawer(),
      bottomNavigationBar: BottomNavbar(),
      body: const Center(child: Text('Hello World')),
    );
  }
}
