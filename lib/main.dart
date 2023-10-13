import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_map/app.dart';
import 'package:test_map/core/function/auth_state_changes.dart';
import 'package:test_map/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  authStateChanges();
  runApp(const MyApp());
}
