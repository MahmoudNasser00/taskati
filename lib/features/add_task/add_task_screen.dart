import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final title = TextEditingController();
  final desc = TextEditingController();

  DateTime? date;
  TimeOfDay? start;
  TimeOfDay? end;
  int color = 0xff5B67F6;

  final colors = [0xff5B67F6, 0xffFF9F5A, 0xffFF5A5A];

  bool get valid =>
      title.text.isNotEmpty && desc.text.isNotEmpty && date != null && start != null && end != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          TextField(controller: title, decoration: const InputDecoration(hintText: 'Title')),
          const SizedBox(height: 12),
          TextField(controller: desc, maxLines: 3, decoration: const InputDecoration(hintText: 'Description')),
          const SizedBox(height: 16),
          _picker('Date', date == null ? 'Select Date' : DateFormat('yyyy-MM-dd').format(date!), () async {
            final d = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2100), initialDate: DateTime.now());
            if (d != null) setState(() => date = d);
          }),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _picker('Start Time', start?.format(context) ?? '--:--', () async {
              final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if (t != null) setState(() => start = t);
            })),
            const SizedBox(width: 12),
            Expanded(child: _picker('End Time', end?.format(context) ?? '--:--', () async {
              final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              if (t != null) setState(() => end = t);
            })),
          ]),
          const SizedBox(height: 20),
          Row(children: colors.map((c) {
            return GestureDetector(
              onTap: () => setState(() => color = c),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(c),
                  shape: BoxShape.circle,
                  border: color == c ? Border.all(width: 2) : null,
                ),
              ),
            );
          }).toList()),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: valid
                  ? () {
                      Hive.box<TaskModel>('tasks').add(TaskModel(
                        title: title.text,
                        description: desc.text,
                        date: date!,
                        startTime: start!.format(context),
                        endTime: end!.format(context),
                        color: color,
                      ));
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Create Task'),
            ),
          )
        ]),
      ),
    );
  }

  Widget _picker(String label, String value, VoidCallback onTap) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label),
      const SizedBox(height: 6),
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(14)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(value),
            const Icon(Icons.access_time, size: 18),
          ]),
        ),
      )
    ]);
  }
}