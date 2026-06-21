import 'package:flutter/material.dart';
import '../../data/services/category_service.dart';

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

  Future<void> save() async {
    setState(() => loading = true);

    await service.createCategory(
      nameCtrl.text,
      descCtrl.text,
    );

    setState(() => loading = false);

    if (!mounted) return;
    Navigator.pop(context);
  }

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
          onPressed: loading ? null : save,
          child: loading
              ? const CircularProgressIndicator()
              : const Text("Guardar"),
        )
      ],
    );
  }
}