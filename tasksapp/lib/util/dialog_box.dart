import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  //onsubmit function
  void Function(String) onSubmit;

  // on create task
  void Function(String) onCreateTask;

  DialogBox({super.key, required this.onSubmit, required this.onCreateTask});

  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new task'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Enter a task name',
        ),
        onSubmitted: (value) {
          onSubmit(value);
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onCreateTask(controller.text);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
