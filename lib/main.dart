import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_realtime/app/auth_gate.dart';
import 'package:flutter_todo_realtime/features/auth/datasource/auth_datasource.dart';
import 'package:flutter_todo_realtime/features/auth/datasource/user_datasource.dart';
import 'package:flutter_todo_realtime/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter_todo_realtime/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final authDatasrouce = AuthDatasource(firebaseAuth: firebaseAuth);

  final authService = AuthService(
    authDatasource: authDatasrouce,
    userDatasource: UserDatasource(),
  );

  runApp(
    ChangeNotifierProvider<AuthNotifier>(
      create: (_) {
        final notifier = AuthNotifier(authService: authService);
        notifier.startAuthListener();
        return notifier;
      },
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
