import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),


      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text("Reportes"),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text(
              "Actualizar",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),

      body: Column(
        children: [


          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Proveedores"),
                Tab(text: "Stock Actual"),
                Tab(text: "Por Vencer"),
                Tab(text: "Stock Bajo"),
                Tab(text: "Ventas"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [


                _providersReport(),

                const Center(child: Text("Stock Actual")),

                const Center(child: Text("Por Vencer")),

                const Center(child: Text("Stock Bajo")),

                const Center(child: Text("Ventas")),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _providersReport() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          // CARD HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Listado de Proveedores",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Información completa de todos los proveedores",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                // FILTER
                Container(
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
                    hint: const Text("Filtrar por categoría"),
                  ),
                ),

                const SizedBox(height: 20),

                // TABLE HEADER
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nombre",
                          style: TextStyle(color: Colors.white)),
                      Text("RUC",
                          style: TextStyle(color: Colors.white)),
                      Text("Correo",
                          style: TextStyle(color: Colors.white)),
                      Text("Teléfono",
                          style: TextStyle(color: Colors.white)),
                      Text("Productos",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ROW
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Carlos Perez"),
                          Text("20123456789"),
                          Text("proveedor@demo.com"),
                          Text("999888777"),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: const [
                          _chip("Gaseosa 600ml"),
                          SizedBox(width: 8),
                          _chip("Agua 500ml"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _chip extends StatelessWidget {
  final String text;

  const _chip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}