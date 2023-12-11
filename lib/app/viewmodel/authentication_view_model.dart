import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopy/app/model/user_model.dart';
import 'package:shopy/app/repository/authentication_repository.dart';
import 'package:shopy/app/repository/user_repository.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/util/enums.dart';

class AuthenticationViewModel with ChangeNotifier {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  AuthenticationViewModel({
    required this.authenticationRepository,
    required this.userRepository,
  });

  RequestStatus requestStatus = RequestStatus.initial;
  String gender = AppStrings.male;
  String imagePath = "";
  late UserModel currentUser;

  Future<void> getCurrentUser(String userId) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      UserModel? user = await userRepository.getUser(userId);

      if (user != null) {
        currentUser = user;
        requestStatus = RequestStatus.loaded;
        notifyListeners();
      }
    } catch (e) {
      print('Error during getting user: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  void setImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  AuthenticationStatus checkAuthenticationStatus() {
    return authenticationRepository.getCurrentUser() != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.notAuthenticated;
  }

  Future<AuthenticationStatus> signUp({
    required String fullName,
    required String email,
    required String birthDate,
    required double weight,
    required double height,
    required String password,
  }) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      final user = await authenticationRepository.signUp(
        UserModel(
          fullName: fullName,
          email: email,
          birthDate: birthDate,
          weight: weight,
          height: height,
          gender: gender,
        ),
        password,
        imagePath,
      );
      requestStatus = RequestStatus.loaded;
      notifyListeners();
      return user != null
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.notAuthenticated;
    } catch (e) {
      print('Error during signup: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
      return AuthenticationStatus.notAuthenticated;
    }
  }

  Future<AuthenticationStatus?> signIn(String email, String password) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      final user = await authenticationRepository.signIn(email, password);
      requestStatus = RequestStatus.loaded;
      notifyListeners();
      return user != null
          ? AuthenticationStatus.authenticated
          : AuthenticationStatus.notAuthenticated;
    } catch (e) {
      print('Error during signIn: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
      return AuthenticationStatus.notAuthenticated;
    }
  }

  void changeGender(String gender) {
    this.gender = gender;
    notifyListeners();
  }

  User? getCurrentFirebaseUser() {
    return authenticationRepository.getCurrentUser();
  }

  Future<void> signOut(Function() onFinish) async {
    try {
      await authenticationRepository.signOut();
      _resetValues();
      onFinish();
    } catch (e) {
      print(e);
    }
  }

  void _resetValues() {
    gender = AppStrings.male;
    imagePath = "";
  }

  void updateCurrentUser({
    required String fullName,
    required String birthDate,
    required double weight,
    required double height,
    required String? imageUrl,
  }) {
    currentUser.fullName = fullName;
    currentUser.birthDate = birthDate;
    currentUser.weight = weight;
    currentUser.height = height;
    currentUser.profilePicture = imageUrl;
    notifyListeners();
  }

  Future<void> resetPassword(String email, Function() onFinish) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      await authenticationRepository.resetPassword(email);
      requestStatus = RequestStatus.loaded;
      notifyListeners();
      onFinish();
    } catch (e) {
      print('Error sending reset password email: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }
}
