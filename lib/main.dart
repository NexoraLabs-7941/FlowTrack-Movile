import 'package:flutter/material.dart';

import 'features/auth/login_page.dart';
import 'features/auth/register_page.dart';

void main() {
  runApp(const FlowTrackApp());
}

class FlowTrackApp extends StatelessWidget {
  const FlowTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // LOGIN como inicio
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),

      },
    );
  }
}