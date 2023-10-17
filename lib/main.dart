import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_map/app.dart';
import 'package:test_map/boot.dart';

void main() async {
  final overrides = await boot();
  runApp(ProviderScope(overrides: overrides, child: const MyApp()));
}
