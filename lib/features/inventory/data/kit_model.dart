
import '../data/models/product_model.dart';
class Kit {
  final String name;
  final List<Product> products;
  final double totalPrice;

  Kit({
    required this.name,
    required this.products,
    required this.totalPrice,
  });
}