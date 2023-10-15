import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'auth_state.dart';

final authProvider =
    StateNotifierProvider<AuthProvider, AuthState>((ref) => AuthProvider());

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthInitial());

  String? phoneNumber;
  late String verificationId;
  GlobalKey<FormState> phoneForm = GlobalKey<FormState>();

  Future<void> signUpWithPhoneNumber() async {
    if (phoneForm.currentState!.validate()) {
      phoneForm.currentState!.save();
      log(phoneNumber!);
      state = AuthLoading();
      log("====AuthLoading====");

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+2$phoneNumber',
        timeout: const Duration(seconds: 14),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    }
  }

  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    log("verificationCompleted==");
    await signIn(credential);
  }

  verificationFailed(FirebaseAuthException e) {
    log("error : ${e.toString()}");
    state = AuthError(e.toString());
  }

  codeSent(String verificationId, int? resendToken) {
    log("codeSent");
    this.verificationId = verificationId;
    state = PhoneNumberSubmitted();
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    log("codeAutoRetrievalTimeout");
  }

  Future<void> submitOtp(String otpCode) async {
    log("submitOtp $otpCode");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    log("signIn *&*&");

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      state = PhoneOtpVerified();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    return FirebaseAuth.instance.currentUser!;
  }
}
