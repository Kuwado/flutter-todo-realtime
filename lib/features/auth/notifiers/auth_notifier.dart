import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/models/user.dart';
import 'package:flutter_todo_realtime/features/auth/services/auth_service.dart';
import 'package:flutter_todo_realtime/features/auth/states/auth_state.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService;
  AuthState _state = AuthState();

  AuthState get state => _state;
  StreamSubscription<User?>? _authSubscription;

  AuthNotifier({required AuthService authService}) : _authService = authService;

  void startAuthListener() {
    _authSubscription?.cancel();

    _authSubscription = _authService.authStateChanges().listen((user) {
      _state = _state.copyWith(
        user: user,
        registerSuccess: _state.registerSuccess,
      );
      notifyListeners();
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
  }) async {
    if (password != confirmPassword) {
      _state = _state.copyWith(
        error: 'Wrong confirm password',
        registerSuccess: false,
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(
      isLoading: true,
      error: null,
      registerSuccess: false,
    );
    notifyListeners();

    try {
      await _authService.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      _state = _state.copyWith(
        isLoading: false,
        registerSuccess: true,
        // user: user,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
        registerSuccess: false,
      );
    }
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      await _authService.signIn(email: email, password: password);
      _state = _state.copyWith(isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _state = AuthState();
    notifyListeners();
  }

  void clearError() {
    if (_state.error != null) {
      _state = _state.copyWith(error: null);
      notifyListeners();
    }
  }

  void clearRegisterSuccess() {
    if (_state.registerSuccess) {
      _state = _state.copyWith(registerSuccess: false);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
