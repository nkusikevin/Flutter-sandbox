import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Task Model
class Task {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String date;
  final String description;
  final String status;
  final bool isCompleted;
  final TaskPriority priority;
  final TaskCategory category;

  Task({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      date: json['date'],
      description: json['description'],
      status: json['status'],
      priority: TaskPriority.values.firstWhere(
          (e) => e.toString() == 'TaskPriority.${json['priority']}'),
      category: TaskCategory.values.firstWhere(
          (e) => e.toString() == 'TaskCategory.${json['category']}'),
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'date': date,
      'description': description,
      'status': status,
      'priority': priority.toString().split('.').last,
      'category': category.toString().split('.').last,
      'isCompleted': isCompleted,
    };
  }

  Task copyWith({
    String? id,
    String? name,
    String? startTime,
    String? endTime,
    String? date,
    String? description,
    String? status,
    TaskPriority? priority,
    TaskCategory? category,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

enum TaskPriority { high, medium, low }

enum TaskCategory { work, personal, others }

// TaskManager
class TaskManager extends StateNotifier<List<Task>> {
  TaskManager() : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final tasksList = jsonDecode(tasksJson) as List;
      state = tasksList.map((taskJson) => Task.fromJson(taskJson)).toList();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(state.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  void addTask(Task task) {
    state = [...state, task];
    _saveTasks();
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
    _saveTasks();
  }

  void toggleTaskCompletion(String id) {
    final task = state.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    updateTask(updatedTask);
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
    _saveTasks();
  }

  List<Task> getTasks() {
    return state;
  }

  List<Task> filterTasks(
      {String? date, TaskPriority? priority, String? status}) {
    return state.where((task) {
      bool dateMatch = date == null || task.date == date;
      bool priorityMatch = priority == null || task.priority == priority;
      bool statusMatch = status == null || task.status == status;
      return dateMatch && priorityMatch && statusMatch;
    }).toList();
  }
}

// Providers
final taskManagerProvider =
    StateNotifierProvider<TaskManager, List<Task>>((ref) {
  return TaskManager();
});

final tasksProvider = Provider<Map<String, int>>((ref) {
  final tasks = ref.watch(taskManagerProvider);
  final completedTasks = tasks
      .where((task) => task.status == 'completed' || task.isCompleted)
      .length;
  final pendingTasks = tasks.where((task) => !task.isCompleted).length;

  final overdueTasks = tasks.where((task) {
    if (task.isCompleted) return false;
    final taskDate = DateTime.parse(task.date);
    final taskEndTime = DateTime.parse('${task.date} ${task.endTime}');
    final now = DateTime.now();
    return taskDate.isBefore(now.subtract(Duration(days: 1))) ||
        (taskDate.year == now.year &&
            taskDate.month == now.month &&
            taskDate.day == now.day &&
            taskEndTime.isBefore(now));
  }).length;
  return {
    'total': tasks.length,
    'completed': completedTasks,
    'pending': pendingTasks,
    'overdue': overdueTasks,
  };
});

final filteredTasksProvider =
    Provider.family<List<Task>, Map<String, dynamic>>((ref, filter) {
  final tasks = ref.watch(taskManagerProvider);

  return tasks.where((task) {
    // Date filter
    if (filter['date'] != null) {
      final filterDate = DateTime.parse(filter['date'] as String);
      final taskDate = DateTime.parse(task.date);
      if (filterDate.year != taskDate.year ||
          filterDate.month != taskDate.month ||
          filterDate.day != taskDate.day) {
        return false;
      }
    }

    // Priority filter
    if (filter['priority'] != null && task.priority != filter['priority']) {
      return false;
    }

    // Status filter
    if (filter['status'] != null && task.status != filter['status']) {
      return false;
    }

    return true;
  }).toList();
});

final filterProvider = StateProvider<Map<String, dynamic>>((ref) => {});
