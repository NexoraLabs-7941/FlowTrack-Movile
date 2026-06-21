import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("Gestión de Ventas"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🧠 TITLE
            const Text(
              "Gestión de Ventas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // 🔍 FILTER BAR
            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: "Bolsa Papitas",
                      items: const [
                        DropdownMenuItem(
                          value: "Bolsa Papitas",
                          child: Text("Bolsa Papitas"),
                        )
                      ],
                      onChanged: (_) {},
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text("Filtro"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📦 PRODUCTS SECTION
            _sectionTitle("Productos"),

            const SizedBox(height: 10),

            _tableHeader(),

            _productRow("Gaseosa 600ml", "S/. 4.50", "5"),
            _productRow("Agua 500ml", "S/. 2.50", "98"),

            const SizedBox(height: 20),

            // 📦 KITS SECTION
            _sectionTitle("Kits"),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Combo Agua x2",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("2 x Agua 500ml"),
                        Text("S/. 5.00"),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Total: S/. 10.00",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🛒 DRAFT SECTION
            _sectionTitle("Borrador de venta"),

            const SizedBox(height: 10),

            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: SizedBox(
                height: 150,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 50, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("El borrador está vacío."),
                    Text("Agrega productos o kits para comenzar."),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 💰 TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "S/. 0.00",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔘 ACTIONS
            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text("Cancelar"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {},
                    child: const Text("Guardar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 📌 TITLE
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // 📊 HEADER
  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Nombre", style: TextStyle(color: Colors.white)),
          Text("Precio", style: TextStyle(color: Colors.white)),
          Text("Stock", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // 📦 ROW
  Widget _productRow(String name, String price, String stock) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            Text(price),
            Text(stock),
            const Icon(Icons.add_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}