import 'package:flutter_todo_realtime/features/auth/models/user.dart';

class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;
  final bool registerSuccess;

  AuthState({
    this.isLoading = false,
    this.user,
    this.error,
    this.registerSuccess = false,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    String? error,
    bool? registerSuccess,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      registerSuccess: registerSuccess ?? false,
    );
  }
}
