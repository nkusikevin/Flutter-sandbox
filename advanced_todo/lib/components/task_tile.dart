import 'package:advanced_todo/components/update_task.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onCompletionChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onCompletionChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryFixedDim,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: onCompletionChanged,
            activeColor: Color.fromRGBO(25, 155, 60, 0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                task.name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted
                      ? Theme.of(context).colorScheme.primaryFixedDim
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              subtitle: Text('${task.startTime} - ${task.endTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: task.isCompleted
                        ? Theme.of(context).colorScheme.primaryFixedDim
                        : Theme.of(context).colorScheme.inversePrimary,
                  )),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Ionicons.create_outline, color: Colors.blue),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdateTaskDialog(task: task);
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Ionicons.trash_outline, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
