import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth firebaseAuth;

  AuthDatasource({required this.firebaseAuth});

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }
}
