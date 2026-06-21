import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app.dart';
import '../../../core/services/auth_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("Configuración"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Configuración",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            "Gestiona las preferencias de la aplicación",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),


          _card(
            icon: Icons.person,
            title: "Información del usuario",
            child: Column(
              children: [
                _row("Correo electrónico", "administrador@gmail.com"),
                const SizedBox(height: 10),
                _row("Rol", "Administrador"),
              ],
            ),
          ),

          const SizedBox(height: 12),


          _card(
            icon: Icons.language,
            title: "Idioma",
            child: Row(
              children: [
                Expanded(child: _langChip("ES", true)),
                const SizedBox(width: 10),
                Expanded(child: _langChip("EN", false)),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ℹ APP INFO
          _card(
            icon: Icons.info_outline,
            title: "Información de la aplicación",
            child: Column(
              children: [
                _row("Versión", "1.0.0"),
                const SizedBox(height: 10),
                _row("Nombre", "FlowTrack"),
              ],
            ),
          ),

          const SizedBox(height: 25),


          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(14),
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Cerrar sesión"),
              onPressed: () async {
                await AuthService().logout();

                AppState.isLogged.value = false;

                if (!context.mounted) return;

                context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _card({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }


  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }


  Widget _langChip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}