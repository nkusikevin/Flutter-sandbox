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
      priority: TaskPriority.values.firstWhere((e) => e.toString() == 'TaskPriority.${json['priority']}'),
      category: TaskCategory.values.firstWhere((e) => e.toString() == 'TaskCategory.${json['category']}'),
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

  int getTotalTasks() {
    return state.length;
  }

  List<Task> getCompletedTasks() {
    return state.where((task) => task.status == 'completed').toList();
  }

  List<Task> getPendingTasks() {
    return state.where((task) => task.status == 'pending').toList();
  }

  List<Task> getOverdueTasks() {
    final now = DateTime.now();
    return state.where((task) {
      final taskDate = DateTime.parse(task.date);
      return taskDate.isBefore(now) && task.status != 'completed';
    }).toList();
  }

  List<Task> filterTasks({String? date, TaskPriority? priority, String? status}) {
    return state.where((task) {
      bool dateMatch = date == null || task.date == date;
      bool priorityMatch = priority == null || task.priority == priority;
      bool statusMatch = status == null || task.status == status;
      return dateMatch && priorityMatch && statusMatch;
    }).toList();
  }
}

// Providers
final taskManagerProvider = StateNotifierProvider<TaskManager, List<Task>>((ref) {
  return TaskManager();
});




final totalTasksProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskManagerProvider);
  return tasks.length;
});

final completedTasksProvider = Provider<List<Task>>((ref) {
  return ref.watch(taskManagerProvider.notifier).getCompletedTasks();
});

final pendingTasksProvider = Provider<List<Task>>((ref) {
  return ref.watch(taskManagerProvider.notifier).getPendingTasks();
});

final overdueTasksProvider = Provider<List<Task>>((ref) {
  return ref.watch(taskManagerProvider.notifier).getOverdueTasks();
});

// Example of a filtered tasks provider
final filteredTasksProvider = Provider.family<List<Task>, Map<String, dynamic>>((ref, filter) {
  return ref.watch(taskManagerProvider.notifier).filterTasks(
    date: filter['date'] as String?,
    priority: filter['priority'] as TaskPriority?,
    status: filter['status'] as String?,
  );
});


// final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));