import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/dashboard/notifiers/todo_notifier.dart';
import 'package:flutter_todo_realtime/features/dashboard/presentation/create_todo_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _shown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final auth = context.watch<AuthNotifier>();
    final todoNotifier = context.read<TodoNotifier>();
    final user = auth.state.user;

    // 🔥 START LISTEN TODOS
    if (user != null) {
      todoNotifier.start(user.uid);
    }

    if (auth.state.registerSuccess && !_shown) {
      _shown = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Đăng ký thành công'),
            duration: Duration(seconds: 2),
          ),
        );

        auth.clearRegisterSuccess();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TodoNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: notifier.todos.isEmpty
          ? const Center(child: Text('No todos'))
          : ListView.builder(
              itemCount: notifier.todos.length,
              itemBuilder: (context, index) {
                final todo = notifier.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.progress),
                  trailing: IconButton(
                    onPressed: () => notifier.deleteTodo(todo.id ?? ''),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateTodoScreen()),
          );
        },
      ),
    );
  }
}
