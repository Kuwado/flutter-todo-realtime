import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/dashboard/models/todo.dart';

class TodoDatasource {
  final FirebaseFirestore firestore;
  TodoDatasource({required this.firestore});

  Future<Todo> addTodo(Todo todo) async {
    final ref = Todo.getCollection(firestore).doc();
    final newTodo = todo.copyWith(id: ref.id);
    await ref.set(newTodo.toFirestore());
    debugPrint(newTodo.title);
    return newTodo;
  }

  Future<void> updateTodo(Todo todo) async {
    await Todo.getCollection(firestore).doc(todo.id).update(todo.toFirestore());
  }

  Future<void> deleteTodo(String id) async {
    await Todo.getCollection(firestore).doc(id).delete();
  }

  Stream<List<Todo>> watchTodos() {
    return Todo.getCollection(firestore).snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList(),
    );
  }

  Stream<List<Todo>> watchTodosByUser(String userId) {
    // debugPrint('🟢 watchTodosByUser START userId = $userId');

    return Todo.getCollection(firestore)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
        });
  }
}
