import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopy/app/model/user_model.dart';
import 'package:shopy/app/services/storage_services.dart';
import 'package:shopy/core/util/constants.dart';

class AuthenticationRepository {
  final StorageServices storageServices;

  AuthenticationRepository({required this.storageServices});

  final _firebaseAuth = FirebaseAuth.instance;
  final _database = FirebaseFirestore.instance;

  Future<User?> signUp(
      UserModel user, String password, String imagePath) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      if (imagePath != '') {
        var imageUrl = await storageServices.uploadImage(
            imagePath, userCredential.user!.uid);
        user.profilePicture = imageUrl;
        print(imageUrl);
      }
      await _database
          .collection(Constants.usersCollection)
          .doc(userCredential.user?.uid)
          .set(user.toDocument());
      await _firebaseAuth.currentUser!.sendEmailVerification();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print('Signup Error: $e');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        await _firebaseAuth.currentUser!.sendEmailVerification();
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      print('SignIn Error: $e');
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
