import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/auth/presentation/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 16,
          left: 32,
          right: 32,
        ),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),

            if (auth.state.error != null)
              Text(
                auth.state.error!,
                style: const TextStyle(color: Colors.red),
              ),

            ElevatedButton(
              onPressed: auth.state.isLoading
                  ? null
                  : () {
                      auth.signIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
              child: auth.state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
