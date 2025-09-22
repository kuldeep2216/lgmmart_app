import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart'; // Import the mock data
import 'package:lgmmart_app/widgets/product_card.dart'; // We will reuse the ProductCard

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits & Vegetables'),
      ),
      body: CustomScrollView(
        slivers: [
          // This is the Category Banner at the top (no changes here)
          SliverToBoxAdapter(
            child: Container(
              height: 150,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1610832958506-aa56368176cf?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fruits & Vegetables',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Fresh and organic produce delivered to your doorstep',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Header for the product list (no changes here)
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Showing ${mockProducts.length} products', // Updated to be dynamic
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                  const Row(
                    children: [
                      Text('Sort by: Recommended'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // *** THIS IS THE MAIN CHANGE ***
          // The Product Grid is now built dynamically from our mock data
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Get the product for the current index
                  final product = mockProducts[index];
                  // Return a ProductCard for that product
                  return ProductCard(product: product);
                },
                // The number of items is the length of our product list
                childCount: mockProducts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                // Using the aspect ratio that you confirmed works perfectly
                childAspectRatio: 0.62,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
