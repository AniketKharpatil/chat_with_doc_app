import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUplaodNewFile {
  static UploadTask uploadFile(String path, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(path);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print("Error occured $e");

      return null;
    }
  }
}
