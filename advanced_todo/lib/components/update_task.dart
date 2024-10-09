import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_field/date_field.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';

class UpdateTaskDialog extends ConsumerStatefulWidget {
  final Task task;

  const UpdateTaskDialog({Key? key, required this.task}) : super(key: key);

  @override
  ConsumerState<UpdateTaskDialog> createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends ConsumerState<UpdateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _taskName;
  late DateTime _selectedDate;
  late TimeOfDay? _startTime;
  late TimeOfDay? _endTime;
  late String _priority;
  late String _category;
  late String _description;

  final List<DropdownMenuEntry<String>> _categories = const [
    DropdownMenuEntry(value: 'Work', label: 'Work'),
    DropdownMenuEntry(value: 'Personal', label: 'Personal'),
    DropdownMenuEntry(value: 'Health', label: 'Health'),
    DropdownMenuEntry(value: 'Finance', label: 'Finance'),
    DropdownMenuEntry(value: 'Other', label: 'Other'),
  ];

  @override
  void initState() {
    super.initState();
    _taskName = widget.task.name;
    _selectedDate = DateTime.parse(widget.task.date);
    _startTime = _parseTimeOfDay(widget.task.startTime);
    _endTime = _parseTimeOfDay(widget.task.endTime);
    _priority = widget.task.priority.toString().split('.').last;
    _category = widget.task.category.toString().split('.').last;
    _description = widget.task.description;
  }

  TimeOfDay? _parseTimeOfDay(String time) {
    if (time.isEmpty) return null;
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

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

      // Create an updated Task object
      final updatedTask = Task(
        id: widget.task.id,
        name: _taskName,
        startTime: startTimeString,
        endTime: endTimeString,
        date: _selectedDate.toIso8601String().split('T')[0],
        description: _description,
        status: widget.task.status,
        priority: _getPriorityEnum(_priority),
        category: _getCategoryEnum(_category),
      );

      // Update the task using the TaskManager
      ref.read(taskManagerProvider.notifier).updateTask(updatedTask);

      // Close the dialog
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
    return AlertDialog(
      title: const Text('Update Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _taskName,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(),
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
                  initialSelection: _category,
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
                initialValue: _selectedDate,
                decoration: const InputDecoration(
                  labelText: 'Enter Date',
                  border: OutlineInputBorder(),
                ),
                mode: DateTimeFieldPickerMode.date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a date';
                  }
                  return null;
                },
                onChanged: (DateTime? value) {
                  setState(() {
                    _selectedDate = value!;
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
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _startTime != null
                              ? _startTime!.format(context)
                              : 'Select Start Time',
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
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _endTime != null
                              ? _endTime!.format(context)
                              : 'Select End Time',
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
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onSaved: (value) => _description = value ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Update Task'),
        ),
      ],
    );
  }
}