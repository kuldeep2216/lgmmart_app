// lib/screens/drinks_juices_screen.dart
import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/widgets/product_card.dart';

class DrinksJuicesScreen extends StatelessWidget {
  const DrinksJuicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter for drinks and juices
    final List<Product> categoryProducts = mockProducts
        .where((product) => product.category == ProductCategory.drinksAndJuices)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cold Drinks & Juices'),
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
