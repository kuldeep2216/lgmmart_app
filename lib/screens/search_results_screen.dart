import 'package:flutter/material.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/widgets/product_card.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;
  final List<Product> results;

  const SearchResultsScreen({
    super.key,
    required this.query,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for "$query"'),
      ),
      body: results.isEmpty
          // Show a message if no products were found
          ? const Center(
              child: Text(
                'No products found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          // Otherwise, display the results in a grid
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ProductCard(product: results[index]);
              },
            ),
    );
  }
}
