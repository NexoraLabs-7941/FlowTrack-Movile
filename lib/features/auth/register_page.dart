import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_input.dart';
import '../../../core/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool h1 = true;
  bool h2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            top: -80,
            right: -70,
            child: _circle(200, AppColors.softOrange),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.inventory_2,
                          color: AppColors.primary),
                      SizedBox(width: 10),
                      Text(
                        "FlowTrack",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Crear cuenta",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Regístrate para comenzar a usar FlowTrack",
                    style: TextStyle(color: AppColors.grey),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        const Icon(Icons.person_add,
                            size: 50, color: AppColors.primary),

                        const SizedBox(height: 20),

                        const CustomInput(
                          label: "Email",
                          icon: Icons.email,
                        ),

                        const SizedBox(height: 14),

                        CustomInput(
                          label: "Contraseña",
                          icon: Icons.lock,
                          obscure: h1,
                          suffix: IconButton(
                            icon: Icon(h1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => h1 = !h1),
                          ),
                        ),

                        const SizedBox(height: 14),

                        CustomInput(
                          label: "Confirmar contraseña",
                          icon: Icons.lock,
                          obscure: h2,
                          suffix: IconButton(
                            icon: Icon(h2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () =>
                                setState(() => h2 = !h2),
                          ),
                        ),

                        const SizedBox(height: 25),

                        PrimaryButton(
                          text: "Crear cuenta",
                          onTap: () {},
                          color: AppColors.success,
                        ),

                        const SizedBox(height: 15),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                              "¿Ya tienes cuenta? Inicia sesión"),
                        )
                      ],
                    ),
                  )
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