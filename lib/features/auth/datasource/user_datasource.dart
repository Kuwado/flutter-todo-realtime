import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_realtime/features/auth/models/user.dart';

class UserDatasource {
  final CollectionReference _users = FirebaseFirestore.instance.collection(
    'users',
  );

  Future<void> createUser(User user) async {
    await _users.doc(user.uid).set(user.toFireStore());
  }

  Future<User?> getUserById(String uid) async {
    final doc = await _users.doc(uid).get();
    if (doc.exists) {
      return User.fromFireStore(uid, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _users.doc(uid).update(data);
  }
}
