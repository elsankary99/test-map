import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/core/function/auth_state_changes.dart';
import 'package:test_map/firebase_options.dart';

Future<List<Override>> boot() async {
  log("=====Boot===");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  authStateChanges();
  final overrides = <Override>[];
  return overrides;
}
