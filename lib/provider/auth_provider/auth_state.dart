part of 'auth_provider.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthDataFetched extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
