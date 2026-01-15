import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();

    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  // Login field
                  TextField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  // Password field
                  TextField(
                    controller: _passwordCtrl,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (auth.state.error != null)
                    Text(
                      auth.state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),

                  // Login button
                  ElevatedButton(
                    onPressed: auth.state.isLoading
                        ? null
                        : () {
                            auth.signIn(
                              email: _emailCtrl.text,
                              password: _passwordCtrl.text,
                            );
                          },
                    child: auth.state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      context.read<AuthNotifier>().clearError();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('Don\'t have an account? Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
