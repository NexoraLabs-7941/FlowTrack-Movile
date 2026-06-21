import 'package:flutter/material.dart';
import '../data/services/dashboard_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
      debugPrint("Dashboard error: $e");

      if (!mounted) return;

      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: false,
        backgroundColor: Colors.orange,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [

                  _statsGrid(),

                  const SizedBox(height: 20),

                  _chart(),

                  const SizedBox(height: 20),

                  _sectionTitle("Productos más vendidos"),

                  ...topProducts.map((p) {
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        leading: const Icon(Icons.local_offer),
                        title: Text(p["name"] ?? ""),
                        trailing: Text("${p["value"] ?? 0}"),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),


                  _sectionTitle("Notificaciones"),

                  ...notifications.map((n) {
                    return Card(
                      color: Colors.orange.shade50,
                      child: ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(n["title"] ?? ""),
                        subtitle: Text(n["message"] ?? ""),
                      ),
                    );
                  }),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }


  Widget _statsGrid() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        _statCard("Productos", products.toString(), Icons.inventory),
        _statCard("Ingresos", "S/. ${income.toStringAsFixed(2)}", Icons.attach_money),
        _statCard("Ventas", sales.toString(), Icons.shopping_cart),
        _statCard("Alertas", alerts.toString(), Icons.warning),
      ],
    );
  }


  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }


  Widget _chart() {
    final data = topProducts.map((e) {
      return SalesData(
        e["name"] ?? "",
        (e["value"] ?? 0).toDouble(),
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: "Ventas"),
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          LineSeries<SalesData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.name,
            yValueMapper: (d, _) => d.value,
            color: Colors.orange,
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


class SalesData {
  final String name;
  final double value;

  SalesData(this.name, this.value);
}