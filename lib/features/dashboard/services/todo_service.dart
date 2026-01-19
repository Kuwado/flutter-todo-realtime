import 'package:flutter_todo_realtime/features/dashboard/datasource/todo_datasource.dart';
import 'package:flutter_todo_realtime/features/dashboard/models/todo.dart';

class TodoService {
  final TodoDatasource datasource;

  TodoService(this.datasource);

  Future<Todo> add(Todo todo) async {
    final newTodo = await datasource.addTodo(todo);
    return newTodo;
  }

  Future<void> update(Todo todo) {
    return datasource.updateTodo(todo);
  }

  Future<void> delete(String id) {
    return datasource.deleteTodo(id);
  }

  Stream<List<Todo>> watchAll() {
    return datasource.watchTodos();
  }

  Stream<List<Todo>> watchByUser(String userId) {
    return datasource.watchTodosByUser(userId);
  }
}
