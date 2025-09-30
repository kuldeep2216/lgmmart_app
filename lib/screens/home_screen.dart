import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/widgets/product_search_delegate.dart';
import 'package:lgmmart_app/widgets/category_card.dart';
import 'package:lgmmart_app/widgets/hero_carousel.dart';
import 'package:lgmmart_app/widgets/offer_banner.dart';
import 'package:lgmmart_app/widgets/product_card.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/screens/dairy_breads_screen.dart';
import 'package:lgmmart_app/screens/drinks_juices_screen.dart';
import 'package:lgmmart_app/screens/fruits_veggies_screen.dart';
import 'package:lgmmart_app/screens/snacks_munchies_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ADD THIS HELPER FUNCTION HERE
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
        leading: const Padding(
          padding: EdgeInsets.only(top: 13, left: 40),
          child: FaIcon(FontAwesomeIcons.basketShopping),
        ),
        title: const Text('LGMMart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // This is the function that opens the search UI
                  showSearch(
                    context: context,
                    delegate: ProductSearchDelegate(),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Row(
                    children: [
                      Icon(FontAwesomeIcons.magnifyingGlass,
                          color: Colors.grey, size: 16),
                      SizedBox(width: 12),
                      Text('Search for products...',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),

            // HERO CAROUSEL IS NOW CORRECTLY PLACED
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: HeroCarousel(),
            ),
            const SizedBox(height: 20),

            // CATEGORY SECTION IS NOW RESTORED
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Shop by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // Use the mockCategories list, not the product list
                itemCount: mockCategories.length,
                itemBuilder: (context, index) {
                  final category = mockCategories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CategoryCard(
                      name: category['name'] as String,
                      imageUrl: category['imageUrl'] as String,
                      onTap: () {
                        // This helper function (defined below) navigates to the correct screen
                        _navigateToCategory(
                            context, category['category'] as ProductCategory);
                      },
                    ),
                  );
                },
              ),
            ),
            const OfferBanner(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Popular Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockProducts.length,
                itemBuilder: (context, index) {
                  final product = mockProducts[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),

            const OfferBanner(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Best Deals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mockProducts.length,
                itemBuilder: (context, index) {
                  final product = mockProducts.reversed.toList()[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
