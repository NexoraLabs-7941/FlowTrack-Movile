class Product {
  final int id;
  final String name;
  final String description;
  final String categoryId;
  final String providerId;
  final int minStock;
  final double unitPrice;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.providerId,
    required this.minStock,
    required this.unitPrice,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      providerId: json['providerId'] ?? '',
      minStock: json['minStock'] ?? 0,
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      isActive: json['isActive'] ?? true,
    );
  }
}