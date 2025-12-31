import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../models/task_model.dart';
import '../../services/user_storage_service.dart';
import '../../core/widgets/empty_tasks.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  bool same(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TaskModel>('tasks');

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskScreen())),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FutureBuilder(
              future: Future.wait([UserStorageService.getName(), UserStorageService.getImage()]),
              builder: (_, s) {
                if (!s.hasData) return const SizedBox();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                      text: 'Hello, ',
                      style: const TextStyle(color: Color(0xff5B67F6), fontSize: 18),
                      children: [
                        TextSpan(text: s.data![0] as String, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                      ],
                    )),
                    CircleAvatar(radius: 24, backgroundImage: FileImage(File(s.data![1] as String))),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (_, i) {
                  final d = DateTime.now().add(Duration(days: i));
                  final sel = same(d, selectedDate);
                  return GestureDetector(
                    onTap: () => setState(() => selectedDate = d),
                    child: Container(
                      width: 64,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: sel ? const Color(0xff5B67F6) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(DateFormat('MMM').format(d), style: TextStyle(color: sel ? Colors.white : Colors.grey)),
                        const SizedBox(height: 4),
                        Text(d.day.toString(),
                            style: TextStyle(color: sel ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(DateFormat('EEE').format(d), style: TextStyle(color: sel ? Colors.white : Colors.grey)),
                      ]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (_, Box<TaskModel> box, __) {
                  final tasks = box.values.where((t) => same(t.date, selectedDate)).toList();
                  if (tasks.isEmpty) return const EmptyTasksWidget();
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (_, i) {
                      final t = tasks[i];
                      return Dismissible(
                        key: ValueKey(t.key),
                        background: Container(color: Colors.green, alignment: Alignment.centerLeft, padding: const EdgeInsets.only(left: 20), child: const Text('Complete', style: TextStyle(color: Colors.white))),
                        secondaryBackground: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Text('Delete', style: TextStyle(color: Colors.white))),
                        confirmDismiss: (d) async {
                          if (d == DismissDirection.startToEnd) {
                            t.isCompleted = true;
                            t.save();
                            return false;
                          } else {
                            t.delete();
                            return true;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Color(t.color), borderRadius: BorderRadius.circular(18)),
                          child: Row(children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(t.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text(t.description, style: const TextStyle(color: Colors.white70)),
                                const SizedBox(height: 8),
                                Text('${t.startTime} - ${t.endTime}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                              ]),
                            ),
                            Container(width: 1, height: 50, color: Colors.white30),
                            const SizedBox(width: 8),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Text(t.isCompleted ? 'DONE' : 'TODO',
                                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            )
                          ]),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}