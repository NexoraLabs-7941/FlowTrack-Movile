import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';
import '../../presentation/widgets/product_table.dart';
import '../../../inventory/data/services/category_service.dart';
import '../../presentation/widgets/kit_modal.dart';
import '../../data/models/kit_model.dart';
import '../../data/services/kit_service.dart';
import '../../presentation/widgets/product_modal.dart';
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
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Inventario"),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("Productos",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [

                      _btn("+ Categoría", Colors.blue, () {
                        showDialog(
                          context: context,
                          builder: (_) => const CategoryModal(),
                        ).then((_) => refresh());
                      }),

                      _btn("+ Kit", Colors.purple, () {
                        showDialog(
                          context: context,
                          builder: (_) => const KitModal(),
                        ).then((_) => refresh());
                      }),

                      _btn("+ Producto", Colors.green, () {
                        showDialog(
                          context: context,
                          builder: (_) => ProductModal(onSaved: refresh),
                        );
                      }),

                      _btn("+ Ingresar Reposición", Colors.orange, () {}),

                    ],
                  ),

                  const SizedBox(height: 16),

                  // PRODUCTS
                  ...products.map((p) {
                    final lowStock = p.minStock <= 5;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(p.name),
                          Text("S/. ${p.unitPrice}"),
                          Text("${p.minStock}"),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: lowStock ? Colors.red : Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              lowStock ? "BAJO" : "NORMAL",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  const Text("Kits",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  ...kits.map((k) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(k.name),
                          Text("S/. ${k.totalPrice}"),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }

  Widget _btn(String text, Color color, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
class CategoryModal extends StatefulWidget {
  const CategoryModal({super.key});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final service = CategoryService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nueva categoría"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              labelText: "Nombre",
              hintText: "Ej: Lácteos",
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(
              labelText: "Descripción",
            ),
          ),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),

        ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  setState(() => loading = true);

                  await service.createCategory(
                    nameCtrl.text,
                    descCtrl.text,
                  );

                  setState(() => loading = false);

                  Navigator.pop(context);
                },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}