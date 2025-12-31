import 'package:shared_preferences/shared_preferences.dart';

class UserStorageService {
  static const _nameKey = 'user_name';
  static const _imageKey = 'user_image';

  static Future<void> saveUser({
    required String name,
    required String imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_imageKey, imagePath);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<String?> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imageKey);
  }

  static Future<bool> hasUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_nameKey) && prefs.containsKey(_imageKey);
  }
}