
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_field/date_field.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';

class CreateTask extends ConsumerStatefulWidget {
  const CreateTask({super.key});

  @override
  ConsumerState<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends ConsumerState<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  DateTime? _selectedDate;
  String _startTime = '';
  String _endTime = '';
  String _priority = '';
  String _category = '';
  String _description = '';

  final List<DropdownMenuEntry<String>> _categories = const [
    DropdownMenuEntry(value: 'Work', label: 'Work'),
    DropdownMenuEntry(value: 'Personal', label: 'Personal'),
    DropdownMenuEntry(value: 'Health', label: 'Health'),
    DropdownMenuEntry(value: 'Finance', label: 'Finance'),
    DropdownMenuEntry(value: 'Other', label: 'Other'),
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Create a new Task object
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate a unique ID
        name: _taskName,
        startTime: _startTime,
        endTime: _endTime,
        date: _selectedDate!.toIso8601String().split('T')[0], // Format date as 'YYYY-MM-DD'
        description: _description,
        status: 'pending',
        priority: _getPriorityEnum(_priority),
        category: _getCategoryEnum(_category),
      );

      // Add the new task using the TaskManager
      ref.read(taskManagerProvider.notifier).addTask(newTask);

      // Navigate back to the previous screen
      Navigator.of(context).pop();
    }
  }

  TaskPriority _getPriorityEnum(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      case 'low':
        return TaskPriority.low;
      default:
        return TaskPriority.medium;
    }
  }

  TaskCategory _getCategoryEnum(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return TaskCategory.work;
      case 'personal':
        return TaskCategory.personal;
      default:
        return TaskCategory.others;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                onSaved: (value) => _taskName = value ?? '',
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownMenu<String>(
                  dropdownMenuEntries: _categories,
                  width: double.infinity,
                  label: const Text('Category'),
                  onSelected: (String? value) {
                    setState(() {
                      _category = value ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                mode: DateTimeFieldPickerMode.date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialPickerDateTime: DateTime.now(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                onChanged: (DateTime? value) {
                  setState(() {
                    _selectedDate = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start time';
                        }
                        return null;
                      },
                      onSaved: (value) => _startTime = value ?? '',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter end time';
                        }
                        return null;
                      },
                      onSaved: (value) => _endTime = value ?? '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = 'High'),
                      child: Card(
                        color: _priority == 'High'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.inversePrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "High",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = 'Medium'),
                      child: Card(
                        color: _priority == 'Medium'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.inversePrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Medium",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = 'Low'),
                      child: Card(
                        color: _priority == 'Low'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.inversePrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Low",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                maxLines: 2,
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: TextButton(
                  onPressed: _submitForm,
                  child: Text('Create Task',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}