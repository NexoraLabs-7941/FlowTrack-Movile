class DashboardModel {
  final int products;
  final double income;
  final int sales;
  final int alerts;

  DashboardModel({
    required this.products,
    required this.income,
    required this.sales,
    required this.alerts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      products: (json["products"] ?? 0) as int,
      income: (json["income"] ?? 0).toDouble(),
      sales: (json["sales"] ?? 0) as int,
      alerts: (json["alerts"] ?? 0) as int,
    );
  }
}