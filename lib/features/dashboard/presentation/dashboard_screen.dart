import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
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
    final auth = context.watch<AuthNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Text('Dashboard ${auth.state.user?.email ?? 'ko co'}'),
      ),
    );
  }
}
