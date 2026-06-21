import 'package:flutter/material.dart';
import '../../data/services/product_service.dart';
import '../../data/services/category_service.dart';
import '../../data/services/supplier_service.dart';
import '../../data/models/category_model.dart';
import '../../data/models/provider_model.dart';

class ProductModal extends StatefulWidget {
  final VoidCallback onSaved;

  const ProductModal({super.key, required this.onSaved});

  @override
  State<ProductModal> createState() => _ProductModalState();
}

class _ProductModalState extends State<ProductModal> {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();
  final minStockCtrl = TextEditingController();

  final productService = ProductService();
  final categoryService = CategoryService();
  final providerService = ProviderService();

  List<Category> categories = [];
  List<Provider> providers = [];

  Category? selectedCategory;
  Provider? selectedProvider;

  bool loadingDropdowns = true;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final cats = await categoryService.getCategories();
      final provs = await providerService.getProviders();
      if (!mounted) return;
      setState(() {
        categories = cats;
        providers = provs;
        loadingDropdowns = false;
      });
    } catch (e) {
      setState(() => loadingDropdowns = false);
    }
  }

  Future<void> save() async {
    if (selectedCategory == null || selectedProvider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona categoría y proveedor")),
      );
      return;
    }

    setState(() => saving = true);

    try {
      await productService.createProduct({
        "name": nameCtrl.text,
        "description": descCtrl.text,
        "categoryId": selectedCategory!.id,
        "providerId": selectedProvider!.id,
        "minStock": int.tryParse(minStockCtrl.text) ?? 0,
        "unitPrice": double.tryParse(priceCtrl.text) ?? 0,
        "isActive": true
      });

      widget.onSaved();
      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nuevo producto"),

      content: loadingDropdowns
          ? const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                children: [

                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),

                  TextField(
                    controller: descCtrl,
                    decoration: const InputDecoration(labelText: "Descripción"),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<Category>(
                    value: selectedCategory,
                    items: categories.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(c.name),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => selectedCategory = v),
                    decoration: const InputDecoration(labelText: "Categoría"),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<Provider>(
                    value: selectedProvider,
                    items: providers.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.fullName),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => selectedProvider = v),
                    decoration: const InputDecoration(labelText: "Proveedor"),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: stockCtrl,
                    decoration: const InputDecoration(labelText: "Stock"),
                    keyboardType: TextInputType.number,
                  ),

                  TextField(
                    controller: minStockCtrl,
                    decoration: const InputDecoration(labelText: "Stock mínimo"),
                    keyboardType: TextInputType.number,
                  ),

                  TextField(
                    controller: priceCtrl,
                    decoration: const InputDecoration(labelText: "Precio"),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),

      actions: [
        TextButton(
          onPressed: saving ? null : () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),

        ElevatedButton(
          onPressed: saving ? null : save,
          child: saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Guardar"),
        ),
      ],
    );
  }
}