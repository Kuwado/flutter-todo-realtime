import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/auth/presentation/login_screen.dart';
import 'package:flutter_todo_realtime/features/dashboard/presentation/dashboard_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final user = authNotifier.state.user;

    if (user == null) {
      return LoginScreen();
    }

    return const DashboardScreen();
  }
}
