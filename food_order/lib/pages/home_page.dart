import 'package:flutter/material.dart';
import 'package:food_order/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        drawer: const SideBar());
  }
}
