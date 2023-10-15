part of 'auth_provider.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SubmitLoading extends AuthState {}

class PhoneOtpVerified extends AuthState {}

class PhoneNumberSubmitted extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
