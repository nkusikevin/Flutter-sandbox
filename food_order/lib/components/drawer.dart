import 'package:flutter/material.dart';
import 'package:food_order/components/drawer_tile.dart';
import 'package:food_order/pages/home_page.dart';
import 'package:food_order/pages/login_page.dart';
import 'package:food_order/pages/setting_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  void handleLogout(context) {
    Navigator.pop(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>  LoginPage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Icon(
            Icons.fastfood,
            size: 100,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        DrawerTile(
          onTap: () {
            Navigator.pop(context);
          },
          title: "H O M E",
          icon: Icons.home,
        ),
        DrawerTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
          title: "S E T T I N G S",
          icon: Icons.settings,
        ),
        const Spacer(),
        DrawerTile(
          onTap: () {
            handleLogout(context);
          },
          title: "L O G O U T",
          icon: Icons.logout,
        ),
        const SizedBox(height: 50),
      ]),
    );
  }
}
