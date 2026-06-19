import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_input.dart';
import '../../../core/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // BACKGROUND
          Positioned(
            top: -80,
            right: -80,
            child: _circle(180, AppColors.softOrange),
          ),

          Positioned(
            bottom: -90,
            left: -60,
            child: _circle(200, const Color(0xFFFFF3E0)),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [

                  const SizedBox(height: 30),

                  // LOGO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.inventory_2,
                          color: AppColors.primary, size: 34),
                      SizedBox(width: 10),
                      Text(
                        "FlowTrack",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 50),

                  const Text(
                    "¡Bienvenido!",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Inicia sesión para continuar",
                    style: TextStyle(color: AppColors.grey),
                  ),

                  const SizedBox(height: 40),

                  const CustomInput(
                    label: "Email",
                    icon: Icons.email,
                  ),

                  const SizedBox(height: 16),

                  CustomInput(
                    label: "Contraseña",
                    icon: Icons.lock,
                    obscure: hide,
                    suffix: IconButton(
                      icon: Icon(
                          hide ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => hide = !hide),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("¿Olvidaste tu contraseña?"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  PrimaryButton(
                    text: "Iniciar sesión",
                    onTap: () {},
                  ),

                  const SizedBox(height: 18),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child:
                        const Text("¿No tienes cuenta? Regístrate"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}