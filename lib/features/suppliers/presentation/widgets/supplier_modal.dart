import 'package:flutter/material.dart';
import '../../../suppliers/data/services/supplier_service.dart';

class SupplierModal extends StatefulWidget {
  final VoidCallback onSaved;

  const SupplierModal({super.key, required this.onSaved});

  @override
  State<SupplierModal> createState() => _SupplierModalState();
}

class _SupplierModalState extends State<SupplierModal> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final rucCtrl = TextEditingController();

  final service = SupplierService();

  bool loading = false;

  Future<void> saveSupplier() async {
    final firstName = firstNameCtrl.text.trim();
    final lastName = lastNameCtrl.text.trim();
    final phoneNumber = phoneCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final ruc = rucCtrl.text.trim();


    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        ruc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final res = await service.createSupplier({
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber, 
        "email": email,
        "ruc": ruc,
      });

      setState(() => loading = false);

      if (!mounted) return;

      if (res == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al guardar proveedor")),
        );
        return;
      }

      widget.onSaved();
      Navigator.pop(context);

    } catch (e) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "Agregar Proveedor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              _field("Nombres*", firstNameCtrl),
              const SizedBox(height: 10),

              _field("Apellidos*", lastNameCtrl),
              const SizedBox(height: 10),

              _field("Celular*", phoneCtrl),
              const SizedBox(height: 10),

              _field("Correo*", emailCtrl),
              const SizedBox(height: 10),

              _field("RUC*", rucCtrl),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: loading ? null : () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: loading ? null : saveSupplier,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: loading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Guardar"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}