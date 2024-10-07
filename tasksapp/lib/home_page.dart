import 'package:flutter/material.dart';
import 'package:tasksapp/todo_tile.dart';
import 'package:tasksapp/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tasks = [
    ["Make an app", false],
    ["Make a website", false],
    ["Make a game", false],
    ["Make a video", false],
    ["Make a song", false],
  ];

  void onSubmit(String value) {
    setState(() {
      tasks.add([value, false]);
    });
  }

  void onCreateTask(String value) {
    print(value);
    setState(() {
      tasks.add([value, false]);
    });
  }

  void _addTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSubmit: onSubmit,
            onCreateTask: onCreateTask,
          );
        });
  }

  void _removeTask() {
    // Remove a task
  }

  void taskChanged(bool? value, int index) {
    setState(() {
      tasks[index][1] = !tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Tasks App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            task: tasks[index][0],
            taskCompleted: tasks[index][1],
            onChanged: (value) => taskChanged(value, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        child: const Icon(Icons.add),
      ),
    );
  }
}
