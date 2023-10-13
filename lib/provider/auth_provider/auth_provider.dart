import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_state.dart';

final authProvider =
    StateNotifierProvider<AuthProvider, AuthState>((ref) => AuthProvider());

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthInitial());

  String? phoneNumber;
  GlobalKey<FormState> phoneForm = GlobalKey<FormState>();

  Future<void> signUpWithPhoneNumber() async {
    if (phoneForm.currentState!.validate()) {
      phoneForm.currentState!.save();
      log(phoneNumber!);
    }
  }
}
