import 'package:flutter/material.dart';
import '../../../models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(task.color),
      child: ListTile(
        title: Text(task.title, style: const TextStyle(color: Colors.white)),
        subtitle:
            Text(task.description, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}