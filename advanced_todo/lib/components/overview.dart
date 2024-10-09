import 'package:advanced_todo/components/grid_card.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class Overview extends ConsumerWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(allTasksProvider);
    final completedTasks = ref.watch(completedTasksProvider);
    final pendingTasks = ref.watch(pendingTasksProvider);
    final overdueTasks = ref.watch(overdueTasksProvider);

    final List<Map<String, dynamic>> types = [
      {
        'title': 'Tasks',
        'description': allTasks.length.toString(),
        'icon': Ionicons.list,
        'color': const Color.fromRGBO(138, 163, 255, 0.965)
      },
      {
        'title': 'Completed',
        'description': completedTasks.length.toString(),
        'icon': Ionicons.checkmark_done_circle,
        'color': const Color.fromRGBO(20, 142, 1, 0.965)
      },
      {
        'title': 'Pending',
        'description': pendingTasks.length.toString(),
        'icon': Ionicons.hourglass,
        'color': const Color.fromRGBO(151, 71, 255, 0.965)
      },
      {
        'title': 'Overdue',
        'description': overdueTasks.length.toString(),
        'icon': Ionicons.time,
        'color': const Color.fromRGBO(237, 190, 125, 0.965)
      },
    ];

    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: types.length,
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