import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String role;
  final DateTime? birthday;

  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.role,
    this.birthday,
  });

  factory User.fromFireStore(String uid, Map<String, dynamic> data) {
    return User(
      uid: uid,
      email: data['email'] as String,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      avatar: data['avatar'] as String,
      role: data['role'] as String,
      birthday: (data['birthday'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'role': role,
      'birthday': birthday != null ? Timestamp.fromDate(birthday!) : null,
    };
  }
}
