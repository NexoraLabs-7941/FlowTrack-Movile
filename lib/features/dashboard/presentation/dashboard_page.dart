import 'package:flutter/material.dart';
import '../data/services/dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final service = DashboardService();

  int products = 0;
  double income = 0;
  int sales = 0;
  int alerts = 0;

  List<Map<String, dynamic>> topProducts = [];
  List<Map<String, dynamic>> notifications = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final p = await service.getProductsCount();
      final i = await service.getMonthlyIncome();
      final a = await service.getLowStockCount();
      final t = await service.getTopProducts();
      final n = await service.getAlerts();

      if (!mounted) return;

      setState(() {
        products = p;
        income = i;
        alerts = a;
        topProducts = t;
        notifications = n;
        loading = false;
      });
    } catch (e) {
      debugPrint(" Dashboard error: $e");

      if (!mounted) return;

      setState(() {
        loading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [

                    const SizedBox(height: 10),

                    _card("Productos en inventario", "$products"),
                    _card("Ingresos del mes", "S/. ${income.toStringAsFixed(2)}"),
                    _card("Ventas realizadas", "$sales"),
                    _card("Productos con alertas", "$alerts"),

                    const SizedBox(height: 10),


                    Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Productos más vendidos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    ...topProducts.map((p) {
                      return ListTile(
                        leading: const Icon(Icons.bar_chart),
                        title: Text(p["name"] ?? ""),
                        trailing: Text("${p["value"] ?? 0}"),
                      );
                    }).toList(),

                    const SizedBox(height: 10),

                    // 🔔 NOTIFICATIONS
                    Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Notificaciones",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    ...notifications.map((n) {
                      return ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(n["title"] ?? ""),
                        subtitle: Text(n["message"] ?? ""),
                      );
                    }).toList(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}