// lib/models/product_model.dart

// An enum is a safe and clean way to define a list of options.
enum ProductCategory {
  fruitsAndVeg,
  dairyAndBreads,
  drinksAndJuices,
  snacksAndMunchies
}

class Product {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final String offer;
  final String deliveryTime;
  final ProductCategory category; // <-- THIS IS THE NEW, REQUIRED LINE

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.offer,
    required this.deliveryTime,
    required this.category, // <-- THIS IS THE NEW, REQUIRED LINE
  });
}
