import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings Page"),
          // backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondary,
              ),
              margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme())
                ],
              ),
            )
          ],
        ));
  }
}
