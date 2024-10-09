import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TaskTile extends StatelessWidget {
  final String name;
  final String startTime;
  final String endTime;

  const TaskTile({
    super.key,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryFixedDim,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: Color.fromRGBO(25, 155, 60, 0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          Expanded(
            child: ListTile(
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text('$startTime - $endTime'),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Ionicons.create_outline, color: Colors.blue),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Ionicons.trash_outline, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
