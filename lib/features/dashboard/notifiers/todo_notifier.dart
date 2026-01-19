import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/dashboard/models/todo.dart';
import 'package:flutter_todo_realtime/features/dashboard/services/todo_service.dart';

class TodoNotifier extends ChangeNotifier {
  final TodoService todoService;

  List<Todo> todos = [];
  bool isLoading = false;
  String? error;

  StreamSubscription<List<Todo>>? _sub;

  TodoNotifier({required this.todoService});

  void start(String userId) {
    _sub?.cancel();

    _sub = todoService.watchByUser(userId).listen((data) {
      todos = data;
      notifyListeners();
    });
  }

  Future<void> addTodo(Todo todo) async {
    try {
      isLoading = true;
      notifyListeners();
      await todoService.add(todo);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTodo(Todo todo) async {
    await todoService.update(todo);
  }

  Future<void> deleteTodo(String id) async {
    await todoService.delete(id);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
