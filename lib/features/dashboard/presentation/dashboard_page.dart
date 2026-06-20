import 'package:flutter/material.dart';
import '../data/dashboard_repository_impl.dart';
import '../data/dashboard_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final repo = DashboardRepositoryImpl();

  DashboardModel? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await repo.getDashboard();

    setState(() {
      data = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // CARD 1
            _card("Productos en inventario", data!.products.toString()),

            // CARD 2
            _card("Ingresos del mes", "S/. ${data!.income}"),

            // CARD 3
            _card("Ventas realizadas este mes", data!.sales.toString()),

            // CARD 4
            _card("Productos con alertas", data!.alerts.toString()),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}