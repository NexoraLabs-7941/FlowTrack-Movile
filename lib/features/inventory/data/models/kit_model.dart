class Kit {
  final int id;
  final String name;
  final double totalPrice;
  final List<KitItem> items;

  Kit({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.items,
  });

  factory Kit.fromJson(Map<String, dynamic> json) {
    return Kit(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      items: (json['items'] as List)
          .map((e) => KitItem.fromJson(e))
          .toList(),
    );
  }
}

class KitItem {
  final int productId;
  final int quantity;
  final double price;

  KitItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory KitItem.fromJson(Map<String, dynamic> json) {
    return KitItem(
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}