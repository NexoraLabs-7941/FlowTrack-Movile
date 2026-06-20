import 'package:flutter/material.dart';
import '../../data/services/product_service.dart';
import '../../data/services/kit_service.dart';

class KitModal extends StatefulWidget {
  const KitModal({super.key});

  @override
  State<KitModal> createState() => _KitModalState();
}

class _KitModalState extends State<KitModal> {
  final nameCtrl = TextEditingController();
  final productService = ProductService();
  final kitService = KitService();

  List<dynamic> products = [];
  Map<int, int> selectedQty = {};

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    products = await productService.getProducts();
    setState(() {});
  }

  double get total {
    double sum = 0;
    for (var p in products) {
      final qty = selectedQty[p.id] ?? 0;
      sum += qty * p.unitPrice;
    }
    return sum;
  }

  void saveKit() async {
    final items = products
        .where((p) => (selectedQty[p.id] ?? 0) > 0)
        .map((p) => {
              "productId": p.id,
              "quantity": selectedQty[p.id],
              "price": p.unitPrice,
            })
        .toList();

    await kitService.createKit({
      "name": nameCtrl.text,
      "items": items,
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nuevo kit"),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),

          const SizedBox(height: 10),

          SizedBox(
            height: 300,
            width: 500,
            child: ListView(
              children: products.map((p) {
                return Row(
                  children: [
                    Checkbox(
                      value: (selectedQty[p.id] ?? 0) > 0,
                      onChanged: (_) {
                        setState(() {
                          selectedQty[p.id] = 1;
                        });
                      },
                    ),
                    Expanded(child: Text(p.name)),
                    Text("Min: ${p.minStock}"),
                    Text("S/. ${p.unitPrice}"),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          selectedQty[p.id] =
                              (selectedQty[p.id] ?? 0) - 1;
                        });
                      },
                    ),
                    Text("${selectedQty[p.id] ?? 0}"),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          selectedQty[p.id] =
                              (selectedQty[p.id] ?? 0) + 1;
                        });
                      },
                    ),
                    Text("S/. ${p.unitPrice}"),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          Text("Total: S/. $total"),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: saveKit,
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}