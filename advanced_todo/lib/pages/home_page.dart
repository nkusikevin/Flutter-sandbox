import 'package:advanced_todo/components/bottom_navbar.dart';
import 'package:advanced_todo/components/overview.dart';
import 'package:advanced_todo/components/task_tile.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskManagerProvider);
    final taskManager = ref.read(taskManagerProvider.notifier);
    final todayTasks = tasks.where((task) {
      final taskDate = DateTime.parse(task.date);
      final today = DateTime.now();
      return taskDate.year == today.year &&
          taskDate.month == today.month &&
          taskDate.day == today.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyDone'),
      ),
      bottomNavigationBar: BottomNavbar(),
      body: Column(
        children: [
          Overview(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today\'s Tasks',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: todayTasks.isEmpty
                ? Center(
                    child: Text('No tasks for today'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: todayTasks.length,
                    itemBuilder: (context, index) {
                      final task = todayTasks[index];
                      return TaskTile(
                        name: task.name,
                        startTime: task.startTime,
                        endTime: task.endTime,
                        isCompleted: task.isCompleted,
                        onCompletionChanged: (bool? newValue) {
                          if (newValue != null) {
                            taskManager.toggleTaskCompletion(task.id);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}