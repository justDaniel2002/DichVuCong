import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';

class FileApi {
  static Future pickimageFromGalery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return null;
    return File(returnImage!.path);
  }

  static Future pickimageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return null;
    print("returnImage");
    print(returnImage);
    return File(returnImage!.path);
  }

  static Future openFile(File file) async {
    final url = file.path;
    try {
      await OpenFile.open(url);
    } catch (e) {
      print(e);
    }
  }
}
