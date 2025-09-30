// lib/screens/fruits_veggies_screen.dart
import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/widgets/product_card.dart';

class FruitsVeggiesScreen extends StatelessWidget {
  const FruitsVeggiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter the main product list
    final List<Product> categoryProducts = mockProducts
        .where((product) => product.category == ProductCategory.fruitsAndVeg)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits & Vegetables'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: categoryProducts[index]);
        },
      ),
    );
  }
}
