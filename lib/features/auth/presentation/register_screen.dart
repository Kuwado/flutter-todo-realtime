import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/auth/presentation/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthNotifier>();
    if (auth.state.registerSuccess) {
      Navigator.of(context).pop();
    }

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
                    'Register',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  // Email field
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
                  // Confirm Password field
                  TextField(
                    controller: _confirmPasswordCtrl,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  // First Name field
                  TextField(
                    controller: _firstNameCtrl,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  // Last Name field
                  TextField(
                    controller: _lastNameCtrl,
                    decoration: const InputDecoration(labelText: 'Last Name'),
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
                            auth.signUp(
                              email: _emailCtrl.text,
                              password: _passwordCtrl.text,
                              confirmPassword: _confirmPasswordCtrl.text,
                              firstName: _firstNameCtrl.text,
                              lastName: _lastNameCtrl.text,
                            );
                          },
                    child: auth.state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Register'),
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      context.read<AuthNotifier>().clearError();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Had an account? Login'),
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
