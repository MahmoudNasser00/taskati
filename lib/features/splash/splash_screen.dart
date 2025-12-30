import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../services/user_storage_service.dart';
import '../profile/profile_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final hasUser = await UserStorageService.hasUser();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => hasUser ? const HomeScreen() : const ProfileScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash.json',
          width: 300,
          repeat: true,
          animate: true,
        ),
      ),
    );
  }
}
