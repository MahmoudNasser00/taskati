import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyTasksWidget extends StatelessWidget {
  const EmptyTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/empty.json',
          width: 300,
          repeat: true,
          animate: true,
        ),
        const SizedBox(height: 20),
        const Text(
          'You do not have any tasks yet!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'Add new tasks to make your days productive.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
