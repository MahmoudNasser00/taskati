import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../models/task_model.dart';
import '../../services/user_storage_service.dart';
import '../add_task/add_task_screen.dart';
import 'widgets/date_selector.dart';
import 'widgets/task_item.dart';
import '../../core/colors.dart';
import '../../core/widgets/empty_tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TaskModel>('tasks');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: Future.wait([
                  UserStorageService.getName(),
                  UserStorageService.getImage(),
                ]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hello, ${snapshot.data![0]}'),
                      CircleAvatar(
                        backgroundImage:
                            FileImage(File(snapshot.data![1] as String)),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AddTaskScreen()),
                  );
                },
                child: const Text('+ Add Task'),
              ),
              const SizedBox(height: 10),
              DateSelector(
                onSelected: (d) => setState(() => selectedDate = d),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (_, Box<TaskModel> box, __) {
                    final tasks = box.values.where((t) =>
                        DateUtils.isSameDay(t.date, selectedDate)).toList();
                    if (tasks.isEmpty) return const EmptyTasksWidget();

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, i) {
                        final task = tasks[i];
                        return Dismissible(
                          key: ValueKey(task.key),
                          onDismissed: (_) => task.delete(),
                          child: TaskItem(task: task),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}