// lib/screens/snacks_munchies_screen.dart
import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/widgets/product_card.dart';

class SnacksMunchiesScreen extends StatelessWidget {
  const SnacksMunchiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filter for snacks and munchies
    final List<Product> categoryProducts = mockProducts
        .where(
            (product) => product.category == ProductCategory.snacksAndMunchies)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Snacks & Munchies'),
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
