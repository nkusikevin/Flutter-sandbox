import 'package:advanced_todo/pages/create_task.dart';
import 'package:advanced_todo/pages/setting_pages.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 8,
          ),
        ],
      ),
      child: BottomAppBar(
        surfaceTintColor: Theme.of(context).colorScheme.inversePrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Ionicons.home_outline),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            //add tasks button
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(50),
              ),
              width: 60,
              height: 60,
              child: IconButton(
                icon: const Icon(Ionicons.add),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/create_task');
                },
              ),
            ),
            IconButton(
              icon: const Icon(Ionicons.settings_outline),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            )
          ],
        ),
      ),
    );
  }
}
