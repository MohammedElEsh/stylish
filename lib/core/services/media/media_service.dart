import 'package:image_picker/image_picker.dart';

abstract class MediaService {
  Future<XFile?> pickImage(ImageSource source);
  Future<List<XFile>> pickMultiImage();
}

class MediaServiceImpl implements MediaService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> pickImage(ImageSource source) async {
    return await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );
  }

  @override
  Future<List<XFile>> pickMultiImage() async {
    return await _picker.pickMultiImage(
      imageQuality: 70,
    );
  }
}
