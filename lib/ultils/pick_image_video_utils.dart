import 'package:file_picker/file_picker.dart';

class PickImageVideoUtils {
  static Future<List<PlatformFile>> selectImages() async {
    List<PlatformFile> files = [];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ["jpg", "png"],
          allowMultiple: true);

      if (result != null) {
        files.addAll(result.files);
        return files;
      } else {
        // User canceled the picker
        return [];
      }
    } catch (e) {
      print('check $e');
      return [];
    }
    // print("Image List Length:" + imageFileList.length.toString());
  }
}
