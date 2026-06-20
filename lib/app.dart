
import 'package:flutter/material.dart';
import 'core/config/router/app_router.dart';

class AppState {
  static final ValueNotifier<bool> isLogged = ValueNotifier(false);
}

class FlowTrackApp extends StatelessWidget {
  const FlowTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'FlowTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
    );
  }
}
