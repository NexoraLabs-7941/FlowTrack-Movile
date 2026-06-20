import 'package:flutter/material.dart';

class YoloPage extends StatelessWidget {
  const YoloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),


      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("YOLO"),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Asistente visual de inventario",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Conteo de productos y afluencia en tiempo real",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  icon: const Icon(Icons.videocam),
                  label: const Text("Nueva Cámara"),
                )
              ],
            ),

            const SizedBox(height: 20),


            Row(
              children: [
                Expanded(child: _kpi("Aforo Actual", "7 / 60")),
                const SizedBox(width: 10),
                Expanded(child: _kpi("Total Ventas Hoy", "1,320")),
                const SizedBox(width: 10),
                Expanded(child: _kpi("Alerta de Capacidad", "Normal", color: Colors.red)),
              ],
            ),

            const SizedBox(height: 20),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: _box(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Cámaras conectadas",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10),

                        _cameraItem("Cámara Pasillo 1", true),
                        _cameraItem("Cámara C1", false),
                        _cameraItem("OBS Virtual Camera", true),
                        _cameraItem("Bing IP Video", true),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // RIGHT - PREVIEW
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [

                      Container(
                        height: 200,
                        decoration: _box(),
                        child: const Center(
                          child: Icon(Icons.videocam,
                              size: 60, color: Colors.grey),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: _box(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Column(
                              children: [
                                Icon(Icons.people),
                                Text("18"),
                                Text("Entradas"),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.exit_to_app),
                                Text("11"),
                                Text("Salidas"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: _box(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Historial YOLO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  _historyRow("Cámara Pasillo 1", "Agua 500ml", "Validado"),
                  _historyRow("Cámara Pasillo 1", "Gaseosa 600ml", "Pendiente"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kpi(String title, String value, {Color? color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }


  Widget _cameraItem(String name, bool online) {
    return ListTile(
      leading: Icon(
        Icons.videocam,
        color: online ? Colors.green : Colors.red,
      ),
      title: Text(name),
      subtitle: Text(online ? "Online" : "Offline"),
      trailing: const Icon(Icons.more_vert),
    );
  }


  Widget _historyRow(String camera, String product, String status) {
    return ListTile(
      title: Text(camera),
      subtitle: Text(product),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: status == "Validado"
              ? Colors.green.withOpacity(0.2)
              : Colors.orange.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(status),
      ),
    );
  }


  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
        )
      ],
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
              controller: nameCtrl,
              decoration: const InputDecoration(
                hintText: "Ej: Lácteos",
                border: OutlineInputBorder(),
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
              controller: descCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Ej: Productos lácteos y derivados",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // BOTONES
            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text("Cancelar"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
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