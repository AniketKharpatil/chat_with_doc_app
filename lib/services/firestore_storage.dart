import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUplaodNewFile {
  static UploadTask uploadFile(String path, File file) {
    try {
      UploadTask taskSnapshot =
          FirebaseStorage.instance.ref('Images/$path').putFile(file);
      // final ref = FirebaseStorage.instance.ref(path);
      // return ref.putFile(file);
      return taskSnapshot;
    } on FirebaseException catch (e) {
      print("Error occured $e");

      return null;
    }
  }
}
