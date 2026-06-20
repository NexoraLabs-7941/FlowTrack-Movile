
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final routes = [
    '/dashboard',
    '/inventory',
    '/suppliers',
    '/sales',
    '/reports',
    '/yolo',
    '/settings',
  ];

  void onTap(int i) {
    setState(() => index = i);
    context.go(routes[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventario"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Proveedores"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Ventas"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reportes"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "YOLO"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Config"),
        ],
      ),
    );
  }
}
