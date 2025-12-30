import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onSelected;
  const DateSelector({super.key, required this.onSelected});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (_, i) {
          final date = DateTime.now().add(Duration(days: i));
          final isSel = DateUtils.isSameDay(date, selected);
          return GestureDetector(
            onTap: () {
              setState(() => selected = date);
              widget.onSelected(date);
            },
            child: Container(
              width: 55,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSel ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('MMM').format(date)),
                  Text(date.day.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}