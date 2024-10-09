import 'package:advanced_todo/components/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Overview extends StatelessWidget {
  Overview({super.key});

  @override
  Widget build(BuildContext context) {
    List types = [
      {
        'title': ' Tasks',
        'description': '3 ',
        'icon': Ionicons.list,
        'color': Color.fromRGBO(138, 163, 255, 0.965)
      },
      {
        'title': 'Completed ',
        'description': '2 ',
        'icon': Ionicons.checkmark_done_circle,
        'color': Color.fromRGBO(20, 142, 1, 0.965)
      },
      {
        'title': 'Pending ',
        'description': '1 ',
        'icon': Ionicons.hourglass,
        'color': Color.fromRGBO(151, 71, 255, 0.965)
      },
      {
        'title': 'Overdue ',
        'description': '0 ',
        'icon': Ionicons.time,
        'color': Color.fromRGBO(237, 190, 125, 0.965)
      },
    ];
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
        itemBuilder: (context, index) => GridCard(
          title: types[index]['title'],
          description: types[index]['description'],
          icon: types[index]['icon'],
          color: types[index]['color'],
        ),
      ),
    );
  }
}
