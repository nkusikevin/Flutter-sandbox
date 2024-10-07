import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasksapp/data/database.dart';
import 'package:tasksapp/todo_tile.dart';
import 'package:tasksapp/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('tasks');
  TasksDataBase tasksDataBase = TasksDataBase();

  @override
  void initState() {
    if (_mybox.get('tasks') == null) {
      tasksDataBase.creatInitialData();
    } else {
      tasksDataBase.loadData();
    }
    super.initState();
  }

  void onSubmit(String value) {
    setState(() {
      tasksDataBase.tasks.add([value, false]);
    });
    tasksDataBase.updateData();
  }

  void onCreateTask(String value) {
    setState(() {
      tasksDataBase.tasks.add([value, false]);
    });
    tasksDataBase.updateData();
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

  void removeTask(int index) {
    setState(() {
      tasksDataBase.tasks.removeAt(index);
    });
    tasksDataBase.updateData();
  }

  void taskChanged(bool? value, int index) {
    setState(() {
      tasksDataBase.tasks[index][1] = !tasksDataBase.tasks[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text(
          'Tasks App',
          style: TextStyle(
            color: Color.fromARGB(255, 57, 57, 57),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount: tasksDataBase.tasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            task: tasksDataBase.tasks[index][0],
            taskCompleted: tasksDataBase.tasks[index][1],
            onChanged: (value) => taskChanged(value, index),
            deleteFunction: (context) => removeTask(index),
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
