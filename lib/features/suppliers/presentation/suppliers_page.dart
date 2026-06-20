import 'package:flutter/material.dart';

class SuppliersPage extends StatelessWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("Proveedores"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Proveedores",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Buscar",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [

                // FILTRAR
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    label: const Text("Filtrar"),
                  ),
                ),

                const SizedBox(width: 10),

                // AGREGAR PROVEEDOR
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const SupplierModal(),
                    );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Agregar Proveedor"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),


            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nombre", style: TextStyle(color: Colors.white)),
                  Text("Celular", style: TextStyle(color: Colors.white)),
                  Text("Correo", style: TextStyle(color: Colors.white)),
                  Text("RUC", style: TextStyle(color: Colors.white)),
                  Text("Acciones", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 10),


            _rowSupplier(
              "Carlos Perez",
              "999888777",
              "proveedor@demo.com",
              "20123456789",
            ),
          ],
        ),
      ),
    );
  }


  Widget _rowSupplier(
    String name,
    String phone,
    String email,
    String ruc,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Nombre
          Expanded(child: Text(name)),

          // Celular
          Expanded(child: Text(phone)),

          // Email
          Expanded(child: Text(email)),

          // RUC
          Expanded(child: Text(ruc)),

          // Acciones
          Row(
            children: const [
              Icon(Icons.edit, color: Colors.blue, size: 18),
              SizedBox(width: 10),
              Icon(Icons.delete, color: Colors.red, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
class SupplierModal extends StatefulWidget {
  const SupplierModal({super.key});

  @override
  State<SupplierModal> createState() => _SupplierModalState();
}

class _SupplierModalState extends State<SupplierModal> {
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final celular = TextEditingController();
  final correo = TextEditingController();
  final ruc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Agregar Proveedor",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),

              const Divider(),

              const SizedBox(height: 10),

              // ROW 1
              Row(
                children: [
                  Expanded(child: _field("Nombres*", Icons.person, nombres)),
                  const SizedBox(width: 10),
                  Expanded(child: _field("Apellidos*", Icons.person, apellidos)),
                ],
              ),

              const SizedBox(height: 10),

              // ROW 2
              Row(
                children: [
                  Expanded(child: _field("Celular*", Icons.phone, celular)),
                  const SizedBox(width: 10),
                  Expanded(child: _field("Correo Electrónico*", Icons.email, correo)),
                ],
              ),

              const SizedBox(height: 10),

              // RUC
              _field("RUC*", Icons.badge, ruc),

              const SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Guardar"),
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


  Widget _field(String label, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}