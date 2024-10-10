import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_field/date_field.dart';
import 'package:advanced_todo/model/tasksDataModel.dart';
import 'package:easy_localization/easy_localization.dart';

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

  final List<DropdownMenuEntry<String>> _categories = [
    DropdownMenuEntry(value: 'Work', label: 'work'.tr()),
    DropdownMenuEntry(value: 'Personal', label: 'personal'.tr()),
    DropdownMenuEntry(value: 'Health', label: 'health'.tr()),
    DropdownMenuEntry(value: 'Finance', label: 'finance'.tr()),
    DropdownMenuEntry(value: 'Other', label: 'other'.tr()),
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
      ref.read(taskManagerProvider.notifier).updateTask(updatedTask);
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
      title: const Text('updateTask').tr(),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _taskName,
                decoration: InputDecoration(
                  labelText: 'taskName'.tr(),
                  border: OutlineInputBorder(),
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
                  initialSelection: _category,
                  dropdownMenuEntries: _categories,
                  width: double.infinity,
                  label: Text('category').tr(),
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
                decoration: InputDecoration(
                  labelText: 'enterDate'.tr(),
                  border: OutlineInputBorder(),
                ),
                mode: DateTimeFieldPickerMode.date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                validator: (value) {
                  if (value == null) {
                    return 'pleaseSelectDate'.tr();
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
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'description'.tr(),
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ).tr(),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextButton(
            onPressed: _submitForm,
            child: Text('updateTask',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                )).tr(),
          ),
        ),
      ],
    );
  }
}
