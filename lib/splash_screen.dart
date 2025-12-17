import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'profile_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
    });

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/task.json',
          width: 250,
          repeat: true,
        ),
      ),
    );
  }
}
