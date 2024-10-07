import 'package:hive_flutter/hive_flutter.dart';

class TasksDataBase {
  List tasks = [];

  final _mayBox = Hive.box('tasks');

  void creatInitialData() {
    tasks = [
      ["Add a new task", false]
    ];
  }

  void loadData() {
    tasks = _mayBox.get('tasks');
  }

  void updateData() {
    _mayBox.put('tasks', tasks);
  }
}
