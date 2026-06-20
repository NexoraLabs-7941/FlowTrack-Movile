import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({super.key});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  final service = ProductService();

  List<Product> products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data = await service.getProducts();
    setState(() {
      products = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text("Nombre")),
        DataColumn(label: Text("Stock")),
        DataColumn(label: Text("Precio")),
      ],
      rows: products.map((p) {
        return DataRow(cells: [
          DataCell(Text(p.name)),
          DataCell(Text("${p.unitPrice}")),
          DataCell(Text("S/. ${p.minStock}")),
        ]);
      }).toList(),
    );
  }
}