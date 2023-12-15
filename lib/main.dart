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
  await Firebase.initializeApp();
  ServicesLocator().init();
  // await FirebaseAuth.instance.signOut();
  runApp(const MyApplication());
}
