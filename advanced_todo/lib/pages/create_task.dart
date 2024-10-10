import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_field/date_field.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateTask extends ConsumerStatefulWidget {
  const CreateTask({super.key});

  @override
  ConsumerState<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends ConsumerState<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName = '';
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _priority = '';
  String _category = '';
  String _description = '';

  final List<DropdownMenuEntry<String>> _categories = [
    DropdownMenuEntry(value: 'Work', label: 'work'.tr()),
    DropdownMenuEntry(value: 'Personal', label: 'personal'.tr()),
    DropdownMenuEntry(value: 'Health', label: 'health'.tr()),
    DropdownMenuEntry(value: 'Finance', label: 'finance'.tr()),
    DropdownMenuEntry(value: 'Other', label: 'other'.tr()),
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Convert TimeOfDay to String
      String startTimeString = _startTime != null
          ? '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}'
          : '';
      String endTimeString = _endTime != null
          ? '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}'
          : '';

      // Create a new Task object
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _taskName,
        startTime: startTimeString,
        endTime: endTimeString,
        date: _selectedDate!.toIso8601String().split('T')[0],
        description: _description,
        status: 'pending',
        priority: _getPriorityEnum(_priority),
        category: _getCategoryEnum(_category),
      );

      // Add the new task using the TaskManager
      ref.read(taskManagerProvider.notifier).addTask(newTask);

      Navigator.pushNamed(context, '/home');
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
        title: const Text('createTask').tr(),
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
                decoration: InputDecoration(
                  labelText: 'taskName'.tr(),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'pleaseEnterTaskName'.tr();
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
                  label: const Text('category').tr(),
                  onSelected: (String? value) {
                    setState(() {
                      _category = value ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              DateTimeFormField(
                decoration: InputDecoration(
                  labelText: 'enterDate'.tr(),
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
                    return 'pleaseSelectDate'.tr();
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
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _startTime ?? TimeOfDay.now(),
                        );
                        if (picked != null && picked != _startTime) {
                          setState(() {
                            _startTime = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'startTime'.tr(),
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _startTime != null
                              ? _startTime!.format(context)
                              : 'selectStartTime'.tr(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: _endTime ?? TimeOfDay.now(),
                        );
                        if (picked != null && picked != _endTime) {
                          setState(() {
                            _endTime = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'endTime'.tr(),
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _endTime != null
                              ? _endTime!.format(context)
                              : 'selectEndTime'.tr(),
                        ),
                      ),
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
                            "high".tr(),
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
                            "medium".tr(),
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
                            "low".tr(),
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
                decoration: InputDecoration(
                  labelText: 'description'.tr(),
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
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Theme.of(context).colorScheme.tertiary),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                ),
                width: double.infinity,
                child: TextButton(
                  onPressed: _submitForm,
                  child: Text('createTask'.tr(),
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
