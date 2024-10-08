import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  void openLocationBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Your Location"),
          content: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: "Enter your location",
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Submit"),
              )
            ],
          ),
        );
      },
    );
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
              Icon(Icons.keyboard_arrow_down_rounded),
            ],
          ),
        )
      ]),
    );
  }
}
