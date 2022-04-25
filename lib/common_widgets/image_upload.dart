import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<String?> uploadFile(File file, String filename) async {
  print("File path:${file.path}");
  try {
    var response = await firebase_storage.FirebaseStorage.instance
        .ref("user_image/$filename")
        .putFile(file);
    return response.storage.ref("user_image/$filename").getDownloadURL();
  } on firebase_storage.FirebaseException catch (e) {
    print(e);
  }
}
