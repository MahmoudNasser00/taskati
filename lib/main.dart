import 'package:flutter/material.dart';
import 'package:taskati/profile_screen.dart';
import 'package:taskati/splash_screen.dart';

import 'add_task_screen.dart';
import 'home_screen.dart';

void main() {
  runApp(const TaskatiApp());
}

class TaskatiApp extends StatelessWidget {
  const TaskatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskati',
      theme: ThemeData(
        primaryColor: const Color(0xFF5B5FE9),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        AddTaskScreen.routeName: (_) => const AddTaskScreen(),
      },
    );
  }
}
