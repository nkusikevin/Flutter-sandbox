import 'package:advanced_todo/components/bottom_navbar.dart';
import 'package:advanced_todo/components/overview.dart';
import 'package:advanced_todo/components/task_tile.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskManagerProvider);
    final taskManager = ref.read(taskManagerProvider.notifier);

    final currentFilter = ref.watch(filterProvider);

    final filteredTasks = ref.watch(filteredTasksProvider(currentFilter));

    void handleDelete(String id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Task').tr(),
            content:
                const Text('Are you sure you want to delete this task?').tr(),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  taskManager.deleteTask(id);
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete'.tr(),
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyDone'),
      ),
      bottomNavigationBar: BottomNavbar(),
      body: Column(
        children: [
          Overview(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'todaysTasks'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: DropdownButton<TaskPriority?>(
                  value: currentFilter['priority'] as TaskPriority?,
                  items: [
                    DropdownMenuItem(value: null, child: Text('all').tr()),
                    ...TaskPriority.values
                        .map((priority) => DropdownMenuItem(
                            value: priority,
                            child:
                                Text(priority.toString().split('.').last).tr()))
                        .toList(),
                  ],
                  onChanged: (TaskPriority? newValue) {
                    ref.read(filterProvider.notifier).update((state) => {
                          ...state,
                          'priority': newValue,
                        });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: const Text("noTasksToday").tr(),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskTile(
                        task: task,
                        onCompletionChanged: (bool? newValue) {
                          if (newValue != null) {
                            taskManager.toggleTaskCompletion(task.id);
                          }
                        },
                        onDelete: () {
                          handleDelete(task.id);
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
