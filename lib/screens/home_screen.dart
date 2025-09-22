import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lgmmart_app/data/mock_data.dart';
import 'package:lgmmart_app/screens/category_screen.dart';
import 'package:lgmmart_app/widgets/category_card.dart';
import 'package:lgmmart_app/widgets/offer_banner.dart';
import 'package:lgmmart_app/widgets/product_card.dart';
import 'package:lgmmart_app/widgets/hero_carousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: FaIcon(FontAwesomeIcons.basketShopping),
        ),
        title: const Text('LGMMart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),

            // *** HERO CAROUSEL PLACEHOLDER (RESTORED) ***
            // *** STEP 2: REPLACE THE CONTAINER WITH THE HERO CAROUSEL WIDGET ***
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: HeroCarousel(),
            ),
            const SizedBox(height: 20),

            // *** CATEGORY SECTION (RESTORED) ***
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Shop by Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CategoryCard(
                    name: 'Fruits & Vegetables',
                    imageUrl:
                        'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=500',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()));
                    },
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    name: 'Dairy & Bakery',
                    imageUrl:
                        'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=500',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryScreen()));
                    },
                  ),
                ],
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
              height: 300,
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
              height: 300,
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
