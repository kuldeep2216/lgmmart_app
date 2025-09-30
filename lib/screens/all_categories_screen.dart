// lib/screens/all_categories_screen.dart
import 'package:flutter/material.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/screens/dairy_breads_screen.dart';
import 'package:lgmmart_app/screens/drinks_juices_screen.dart';
import 'package:lgmmart_app/screens/fruits_veggies_screen.dart';
import 'package:lgmmart_app/screens/snacks_munchies_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  // This helper function decides which screen to navigate to
  void _navigateToCategory(BuildContext context, ProductCategory category) {
    Widget screen;
    switch (category) {
      case ProductCategory.fruitsAndVeg:
        screen = const FruitsVeggiesScreen();
        break;
      case ProductCategory.dairyAndBreads:
        screen = const DairyBreadsScreen();
        break;
      case ProductCategory.drinksAndJuices:
        screen = const DrinksJuicesScreen();
        break;
      case ProductCategory.snacksAndMunchies:
        screen = const SnacksMunchiesScreen();
        break;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        automaticallyImplyLeading: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: mockCategories.length,
        itemBuilder: (context, index) {
          final category = mockCategories[index];
          return _buildCategoryCard(
            context,
            category['name'] as String,
            category['imageUrl'] as String,
            // The onTap now calls our helper function with the correct category
            () => _navigateToCategory(
                context, category['category'] as ProductCategory),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Expanded(
              child: Image.network(imageUrl,
                  fit: BoxFit.cover, width: double.infinity),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}
