import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  const DrawerTile(
      {super.key, required this.onTap, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        onTap: onTap,
        title: Text(title,
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        leading:
            Icon(icon, color: Theme.of(context).colorScheme.inversePrimary),
      ),
    );
  }
}
