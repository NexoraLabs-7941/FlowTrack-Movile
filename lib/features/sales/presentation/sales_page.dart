import 'package:flutter/material.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),


      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("Gestión de Ventas"),
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
              "Gestión de Ventas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),


            Row(
              children: [

                // DROPDOWN
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
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

                // FILTRO
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text("Filtro"),
                ),
              ],
            ),

            const SizedBox(height: 20),


            const Text(
              "Productos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _tableHeader(["Nombre", "Precio unitario", "Stock"]),

            _productRow("Gaseosa 600ml", "S/. 4.50", "5"),
            _productRow("Agua 500ml", "S/. 2.50", "98"),

            const SizedBox(height: 20),


            const Text(
              "Kits",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Combo Agua x2"),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("2  Agua 500ml"),
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

            const SizedBox(height: 20),


            const Text(
              "Borrador salida de productos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
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

            const SizedBox(height: 20),


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
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
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


  Widget _tableHeader(List<String> cols) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: cols
            .map((e) => Text(e,
                style: const TextStyle(color: Colors.white)))
            .toList(),
      ),
    );
  }


  Widget _productRow(String name, String price, String stock) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(price),
          Text(stock),
          const Icon(Icons.add_shopping_cart, color: Colors.green),
        ],
      ),
    );
  }
}