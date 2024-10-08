import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  void openLocationBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Your Location'),
              content: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search address...',
                ),
              ),
              actions: [
                //cancel button
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                //save button
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Save'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Delivery Now",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        GestureDetector(
          onTap: () => openLocationBox(context),
          child: Row(
            children: [
              Text(
                "KK 18AV Kanombe",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).colorScheme.primary),
            ],
          ),
        )
      ]),
    );
  }
}
