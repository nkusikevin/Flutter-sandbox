import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String task;
  final bool taskCompleted;
  Function(bool?) onChanged;

  TodoTile({
    super.key,
    required this.task,
    required this.taskCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              task,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.blue[400],
                shape: CircleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 2,
                  ),
                )),
          ),
        ));
  }
}
