import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final _picker = ImagePicker();

  static Future<String?> gallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    return file?.path;
  }

  static Future<String?> camera() async {
    final file = await _picker.pickImage(source: ImageSource.camera);
    return file?.path;
  }
}