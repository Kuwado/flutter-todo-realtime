import 'dart:async';

import 'package:flutter_todo_realtime/features/auth/datasource/auth_datasource.dart';
import 'package:flutter_todo_realtime/features/auth/datasource/user_datasource.dart';
import 'package:flutter_todo_realtime/features/auth/models/user.dart';

class AuthService {
  final AuthDatasource _authDatasource;
  final UserDatasource _userDatasource;

  AuthService({
    required AuthDatasource authDatasource,
    required UserDatasource userDatasource,
  }) : _authDatasource = authDatasource,
       _userDatasource = userDatasource;

  Future<User?> getCurrentUser() async {
    final user = await _authDatasource.getCurrentUser();
    if (user == null) return null;
    return _userDatasource.getUserById(user.uid);
  }

  Future<User?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final firebaseUser = await _authDatasource.signUp(
      email: email,
      password: password,
    );
    if (firebaseUser == null) return null;

    final user = User(
      uid: firebaseUser.uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: '',
      role: 'user',
    );

    await _userDatasource.createUser(user);
    return user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final firebaseUser = await _authDatasource.signIn(
      email: email,
      password: password,
    );

    final user = await _userDatasource.getUserById(firebaseUser!.uid);
    if (user == null) throw Exception('User data not found');
    return user;
  }

  Future<void> signOut() async {
    await _authDatasource.signOut();
  }

  Stream<User?> authStateChanges() {
    return _authDatasource.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return _userDatasource.getUserById(firebaseUser.uid);
    });
  }
}
