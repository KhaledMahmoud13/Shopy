import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopy/app/repository/shop_repository.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/application.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAQpHW-T8OitPl2qbkWphA1ygmcsNYM8aI',
      appId: '1:792724638506:android:1e6728d572fb6c94eaec53',
      messagingSenderId: '',
      projectId: 'shopy-33ba6',
      storageBucket: 'gs://shopy-33ba6.appspot.com',
    ),
  );
  ServicesLocator().init();
  // await FirebaseAuth.instance.signOut();
  runApp(const MyApplication());
}
