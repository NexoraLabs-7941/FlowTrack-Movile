import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),


      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Inventario"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            const Text(
              "Productos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),


            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const CategoryModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("+ Categoría"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const KitModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text("+ Kit"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {  showDialog(
                        context: context,
                        builder: (_) => const ProductModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("+ Producto"),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {  showDialog(
                        context: context,
                        builder: (_) => const RepositionModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text("+ Reposición"),
                  ),
                ),
              ],
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

            const SizedBox(height: 16),


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
                  Text("Precio", style: TextStyle(color: Colors.white)),
                  Text("Stock", style: TextStyle(color: Colors.white)),
                  Text("Estado", style: TextStyle(color: Colors.white)),
                  Text("Acciones", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            _row("Gaseosa 600ml", "S/. 4.50", "5", "STOCK BAJO", Colors.orange),
            _row("Agua 500ml", "S/. 2.50", "98", "NORMAL", Colors.green),

            const SizedBox(height: 20),

            const Text(
              "Kits",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _kitCard(),
          ],
        ),
      ),
    );
  }

  // 📦 ROW PRODUCT
  Widget _row(String name, String price, String stock, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: color)),
          ),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }


  Widget _kitCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Combo Agua x2",
              style: TextStyle(fontWeight: FontWeight.bold)),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("2x Agua 500ml"),
              Text("S/. 5.00"),
            ],
          ),

          SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Total: S/. 10.00",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
class CategoryModal extends StatelessWidget {
  const CategoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              "Nueva categoría",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // NOMBRE
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Nombre"),
            ),

            const SizedBox(height: 5),

            TextField(
              decoration: InputDecoration(
                hintText: "Ej: Lácteos",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // DESCRIPCIÓN
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Descripción"),
            ),

            const SizedBox(height: 5),

            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Ej: Productos lácteos y derivados",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
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
    );
  }
}
class KitModal extends StatefulWidget {
  const KitModal({super.key});

  @override
  State<KitModal> createState() => _KitModalState();
}

class _KitModalState extends State<KitModal> {
  final nameController = TextEditingController();

  int qty1 = 0;
  int qty2 = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nuevo kit",
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

            // NAME
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // TABLE HEADER
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nombre",
                      style: TextStyle(color: Colors.white)),
                  Text("Stock actual",
                      style: TextStyle(color: Colors.white)),
                  Text("Cantidad",
                      style: TextStyle(color: Colors.white)),
                  Text("Precio",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ROW 1
            _kitRow(
              name: "Gaseosa 600ml",
              stock: "5",
              price: "0",
              qty: qty1,
              onMinus: () {
                setState(() {
                  if (qty1 > 0) qty1--;
                });
              },
              onPlus: () {
                setState(() {
                  qty1++;
                });
              },
            ),

            // ROW 2
            _kitRow(
              name: "Agua 500ml",
              stock: "98",
              price: "0",
              qty: qty2,
              onMinus: () {
                setState(() {
                  if (qty2 > 0) qty2--;
                });
              },
              onPlus: () {
                setState(() {
                  qty2++;
                });
              },
            ),

            const SizedBox(height: 20),

            // BUTTONS
            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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


  Widget _kitRow({
    required String name,
    required String stock,
    required String price,
    required int qty,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // NAME + RADIO
          Row(
            children: [
              const Icon(Icons.circle_outlined, size: 18),
              const SizedBox(width: 8),
              Text(name),
            ],
          ),

          Text(stock),

          // QTY SELECTOR
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onMinus,
              ),
              Text(qty.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onPlus,
              ),
            ],
          ),

          // PRICE
          SizedBox(
            width: 50,
            child: TextField(
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(6),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ProductModal extends StatefulWidget {
  const ProductModal({super.key});

  @override
  State<ProductModal> createState() => _ProductModalState();
}

class _ProductModalState extends State<ProductModal> {
  final nameController = TextEditingController(text: "Leche Gloria");
  final descController = TextEditingController();

  bool active = true;

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

              // TITLE
              const Text(
                "Nuevo producto",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // NOMBRE
              _field("Nombre", "Leche Gloria", controller: nameController),

              const SizedBox(height: 10),

              // DESCRIPCIÓN
              _field(
                "Descripción",
                "Ej: Leche entera en envase de 1 litro",
                controller: descController,
                maxLines: 3,
              ),

              const SizedBox(height: 10),

              // CATEGORÍA
              _dropdown("Categoría"),

              const SizedBox(height: 10),

              // PROVEEDOR
              _dropdown("Proveedor"),

              const SizedBox(height: 10),

              // STOCK MÍNIMO
              _field("Stock mínimo", "0"),

              const SizedBox(height: 10),

              // PRECIO
              Row(
                children: [
                  const Text("S/"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Precio unitario",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ESTADO
              Row(
                children: [
                  Checkbox(
                    value: active,
                    onChanged: (v) {
                      setState(() {
                        active = v ?? true;
                      });
                    },
                  ),
                  const Text("Producto activo"),
                ],
              ),

              const SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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

  // FIELD
  Widget _field(String label, String hint,
      {TextEditingController? controller, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // DROPDOWN
  Widget _dropdown(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        items: const [],
        onChanged: (_) {},
        hint: Text(label),
      ),
    );
  }
}
class RepositionModal extends StatefulWidget {
  const RepositionModal({super.key});

  @override
  State<RepositionModal> createState() => _RepositionModalState();
}

class _RepositionModalState extends State<RepositionModal> {
  final loteController = TextEditingController(text: "L-01");

  int quantity = 0;

  DateTime? fechaRecepcion;
  DateTime? fechaVencimiento;

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
                    "Ingresar reposición",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    icon: const Icon(Icons.auto_fix_high),
                    label: const Text("Usar YOLO"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // LOTE
              Row(
                children: [
                  const Text("Lote"),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: loteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // FECHAS
              Row(
                children: [

                  Expanded(
                    child: _dateField(
                      "Fecha recepción",
                      fechaRecepcion,
                      () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        setState(() => fechaRecepcion = date);
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _dateField(
                      "Fecha vencimiento",
                      fechaVencimiento,
                      () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        setState(() => fechaVencimiento = date);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // TABLE HEADER
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nombre", style: TextStyle(color: Colors.white)),
                    Text("Stock actual", style: TextStyle(color: Colors.white)),
                    Text("Cantidad ingresando", style: TextStyle(color: Colors.white)),
                    Text("Total", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ROW PRODUCT
              _row(),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("+ Agregar producto"),
                ),
              ),

              const SizedBox(height: 20),

              // BUTTONS
              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        side: const BorderSide(color: Colors.orange),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
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
      ),
    );
  }

  Widget _dateField(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            const Icon(Icons.calendar_month),
          ],
        ),
      ),
    );
  }

  // ROW
  Widget _row() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // NAME
          const Expanded(
            child: Text("Seleccionar"),
          ),

          const Text("0"),

          // QUANTITY
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    if (quantity > 0) quantity--;
                  });
                },
              ),
              Text("$quantity"),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),

          const Text("0"),
        ],
      ),
    );
  }
}