import 'package:advanced_todo/components/grid_card.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return GridCard(
              title: 'Tasks',
              description: '3 tasks',
              icon: Icons.task,
              color: Theme.of(context).colorScheme.secondary);
        },
      ),
    );
  }
}
