import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  static const routeName = '/add-task';
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Title')),
            const TextField(
              decoration: InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(labelText: 'Date')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
