import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/dashboard/models/todo.dart';
import 'package:flutter_todo_realtime/features/dashboard/notifiers/todo_notifier.dart';
import 'package:provider/provider.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();

  String _priority = 'low';
  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    final todoNotifier = context.watch<TodoNotifier>();
    return Scaffold(
      appBar: AppBar(title: const Text('Create Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),

            DropdownButton<String>(
              value: _priority,
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'high', child: Text('High')),
              ],
              onChanged: (v) => setState(() => _priority = v!),
            ),

            TextField(
              controller: _tagsCtrl,
              decoration: const InputDecoration(
                labelText: 'Tags (comma separated)',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                final now = DateTime.now();

                final todo = Todo(
                  id: '', // Firestore sẽ gán
                  userId: auth.state.user!.uid,
                  title: _titleCtrl.text.trim(),
                  description: _descCtrl.text.trim(),
                  priority: _priority,
                  progress: 'waiting',
                  tags: _tagsCtrl.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList(),
                  startDate: _startDate ?? now,
                  dueDate: _dueDate ?? now,
                  createdAt: now,
                  updatedAt: now,
                );

                await todoNotifier.addTodo(todo);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Create Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
