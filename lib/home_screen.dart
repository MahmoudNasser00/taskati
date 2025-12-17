import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'task_card.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Sayed'),
        actions: const [
          Padding(padding: EdgeInsets.all(8), child: CircleAvatar()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTaskScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TaskCard(title: 'Flutter Task - 1', color: Color(0xFF5B5FE9)),
          TaskCard(title: 'Flutter Task - 2', color: Color(0xFFFF5A7A)),
          TaskCard(title: 'Flutter Task - 3', color: Color(0xFFFFA26B)),
        ],
      ),
    );
  }
}
