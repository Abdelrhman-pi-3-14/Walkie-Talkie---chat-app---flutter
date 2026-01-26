import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickFromGallery() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) return null;

    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return image != null ? File(image.path) : null;
  }

  Future<File?> pickFromCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return null;
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    return image != null ? File(image.path) : null;
  }
}
