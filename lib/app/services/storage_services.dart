import 'dart:io';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopy/core/util/constants.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String imagePath, String userId) async {
    String? imageUrl;
    try {
      final Reference storageReference =
          _storage.ref().child(Constants.profilePicturesPath).child(userId);

      String fileExtension = extension(imagePath);
      final SettableMetadata metadata =
          SettableMetadata(contentType: 'image/${fileExtension.substring(1)}');
      print(metadata.contentType);

      final UploadTask uploadTask = storageReference.putFile(
        File(imagePath),
        metadata,
      );

      await uploadTask.whenComplete(() async {
        imageUrl = await storageReference.getDownloadURL();
        return imageUrl;
      });
    } catch (e) {
      print("Error uploading image to Firebase Storage: $e");
      return null;
    }
    return imageUrl;
  }
}
