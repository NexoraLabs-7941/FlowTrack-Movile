import 'package:flutter/material.dart';
import '../data/services/supplier_service.dart';
import '../data/models/supplier_model.dart';
import 'widgets/supplier_modal.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  final service = SupplierService();

  List<Supplier> suppliers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await service.getSuppliers();

    setState(() {
      suppliers = data;
      loading = false;
    });
  }

  void refresh() {
    setState(() => loading = true);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          "Proveedores",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => SupplierModal(onSaved: refresh),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Agregar"),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Gestión de proveedores",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),


                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Expanded(child: Text("Proveedor", style: TextStyle(color: Colors.white))),
                        Expanded(child: Text("Celular", style: TextStyle(color: Colors.white))),
                        Expanded(child: Text("Correo", style: TextStyle(color: Colors.white))),
                        Expanded(child: Text("RUC", style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),


                  ...suppliers.map((s) {
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${s.firstName} ${s.lastName}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(child: Text(s.phone ?? "-")),
                            Expanded(child: Text(s.email ?? "-")),
                            Expanded(child: Text(s.ruc ?? "-")),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}