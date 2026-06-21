import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';
import '../../../inventory/data/services/category_service.dart';
import '../../presentation/widgets/kit_modal.dart';
import '../../data/models/kit_model.dart';
import '../../data/services/kit_service.dart';
import '../../presentation/widgets/product_modal.dart';
import '../../presentation/widgets/category_modal.dart';
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final productService = ProductService();
  final kitService = KitService();

  List<Product> products = [];
  List<Kit> kits = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final p = await productService.getProducts();
      final k = await kitService.getKits();

      setState(() {
        products = p;
        kits = k;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      debugPrint("Error loading inventory: $e");
    }
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
          "Inventario",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const Text(
                    "Gestión de Inventario",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),


                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [

                      FilledButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const CategoryModal(),
                          ).then((_) => refresh());
                        },
                        icon: const Icon(Icons.category),
                        label: const Text("Categoría"),
                      ),

                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const KitModal(),
                          ).then((_) => refresh());
                        },
                        icon: const Icon(Icons.inventory_2),
                        label: const Text("Kit"),
                      ),

                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ProductModal(onSaved: refresh),
                          );
                        },
                        icon: const Icon(Icons.add_box),
                        label: const Text("Producto"),
                      ),

                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.sync),
                        label: const Text("Reposición"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),


                  _sectionTitle("Productos"),

                  const SizedBox(height: 10),

                  ...products.map((p) {
                    final lowStock = p.minStock <= 5;

                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: const Icon(Icons.inventory),
                        ),
                        title: Text(
                          p.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text("Precio: S/. ${p.unitPrice}"),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: lowStock ? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            lowStock ? "BAJO" : "OK",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 25),


                  _sectionTitle("Kits"),

                  const SizedBox(height: 10),

                  ...kits.map((k) {
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.inventory_2,
                          color: Colors.purple,
                        ),
                        title: Text(
                          k.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "S/. ${k.totalPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}