import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/storage/token_storage.dart';
import '../../widgets/navigation/app_shell.dart';
import '../../../features/auth/presentation/login_page.dart';
import '../../../features/auth/presentation/register_page.dart';
import '../../../features/dashboard/presentation/dashboard_page.dart';
import '../../../features/inventory/presentation/pages/inventory_page.dart';
import '../../../features/suppliers/presentation/suppliers_page.dart';
import '../../../features/sales/presentation/sales_page.dart';
import '../../../features/reports/presentation/reports_page.dart';
import '../../../features/yolo/presentation/yolo_page.dart';
import '../../../features/settings/presentation/settings_page.dart';
import '../../../features/inventory/presentation/pages/yolo_inventory_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  refreshListenable: AppState.isLogged,

  redirect: (context, state) {
    final logged = AppState.isLogged.value;

    final isAuthRoute =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    final isProtectedRoute =
        state.matchedLocation.startsWith('/dashboard') ||
        state.matchedLocation.startsWith('/inventory') ||
        state.matchedLocation.startsWith('/suppliers') ||
        state.matchedLocation.startsWith('/sales') ||
        state.matchedLocation.startsWith('/reports') ||
        state.matchedLocation.startsWith('/yolo') ||
        state.matchedLocation.startsWith('/settings');

    if (!logged && isProtectedRoute) {
      return '/login';
    }

    if (logged && isAuthRoute) {
      return '/dashboard';
    }

    return null;
  },

  routes: [

    GoRoute(
      path: '/login',
      builder: (c, s) => const LoginPage(),
    ),

    GoRoute(
      path: '/register',
      builder: (c, s) => const RegisterPage(),
    ),


    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },

      routes: [

        GoRoute(
          path: '/dashboard',
          builder: (c, s) => const DashboardPage(),
        ),

        GoRoute(
          path: '/inventory',
          builder: (c, s) => const InventoryPage(),
        ),
        GoRoute(
          path: '/inventory/yolo',
          builder: (c, s) => const YoloInventoryPage(),
        ),
        GoRoute(
          path: '/suppliers',
          builder: (c, s) => const SuppliersPage(),
        ),

        GoRoute(
          path: '/sales',
          builder: (c, s) => const SalesPage(),
        ),

        GoRoute(
          path: '/reports',
          builder: (c, s) => const ReportsPage(),
        ),

        GoRoute(
          path: '/yolo',
          builder: (c, s) => const YoloPage(),
        ),

        GoRoute(
          path: '/settings',
          builder: (c, s) => const SettingsPage(),
        ),
      ],
    ),
  ],
);