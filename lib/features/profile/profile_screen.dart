import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/image_picker_service.dart';
import '../../services/user_storage_service.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? image;
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage:
                  image != null ? FileImage(File(image!)) : null,
              child: image == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                image = await ImagePickerService.gallery();
                setState(() {});
              },
              child: const Text('Pick Image'),
            ),
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(hintText: 'Enter your name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (image == null || nameController.text.isEmpty) return;
                await UserStorageService.saveUser(
                    nameController.text, image!);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const HomeScreen()),
                );
              },
              child: const Text('Continue'),
            )
          ],
        ),
      ),
    );
  }
}