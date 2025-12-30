import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: title, decoration: const InputDecoration(hintText: 'Title')),
            TextField(controller: desc, decoration: const InputDecoration(hintText: 'Description')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (title.text.isEmpty || desc.text.isEmpty) return;
                Hive.box<TaskModel>('tasks').add(
                  TaskModel(
                    title: title.text,
                    description: desc.text,
                    date: DateTime.now(),
                    startTime: '09:00',
                    endTime: '10:00',
                    color: 0xff5B67F6,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Create Task'),
            )
          ],
        ),
      ),
    );
  }
}