import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/user_storage_service.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imagePath;
  final nameController = TextEditingController();

  Future<void> pick(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) setState(() => imagePath = file.path);
  }

  Future<void> save() async {
    if (imagePath == null || nameController.text.trim().isEmpty) return;
    await UserStorageService.saveUser(
      name: nameController.text.trim(),
      imagePath: imagePath!,
    );
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
              child: imagePath == null ? const Icon(Icons.person, size: 40) : null,
            ),
            const SizedBox(height: 20),
            _btn('Upload From Camera', () => pick(ImageSource.camera)),
            const SizedBox(height: 12),
            _btn('Upload From Gallery', () => pick(ImageSource.gallery)),
            const SizedBox(height: 20),
            TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Enter your name')),
            const SizedBox(height: 20),
            _btn('Continue', save),
          ],
        ),
      ),
    );
  }

  Widget _btn(String t, VoidCallback f) {
    return SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: f, child: Text(t)));
  }
}