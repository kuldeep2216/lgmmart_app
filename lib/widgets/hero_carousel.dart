import 'package:flutter/material.dart';
// Import the new package
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:lgmmart_app/utils/app_theme.dart';

class HeroCarousel extends StatelessWidget {
  const HeroCarousel({super.key});

  // Data for our carousel slides, now with local asset paths
  final List<Map<String, String>> carouselItems = const [
    {
      'imageUrl': 'assets/images/carousel_1.jpg', // <-- CHANGED
      'title': 'Fresh Groceries Delivered to Your Door',
      'subtitle': 'Get everything you need in just 30 minutes!',
    },
    {
      'imageUrl': 'assets/images/carousel_2.jpg', // <-- CHANGED
      'title': 'Healthy & Organic Choices',
      'subtitle': 'Farm fresh fruits and veggies at your doorstep.',
    },
    {
      'imageUrl': 'assets/images/carousel_3.jpg', // <-- CHANGED
      'title': 'Fast & Reliable Delivery',
      'subtitle': 'Your groceries, delivered in under 30 minutes!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Create a list of widgets from our data
    List<Widget> imageWidgets = carouselItems.map((item) {
      return Stack(
        children: [
          // Background Image
          // **THE FIX IS HERE**: Use Image.asset() instead of Image.network()
          Image.asset(
            item['imageUrl']!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Dark Overlay for text readability
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Centered Text and Button
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['title']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['subtitle']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Shop Now'),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();

    // Use a SizedBox to give the carousel a specific size
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: AnotherCarousel(
        images: imageWidgets, // Pass the list of widgets here
        dotSize: 8.0,
        dotSpacing: 15.0,
        dotColor: AppColors.primary.withOpacity(0.5),
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.transparent,
        borderRadius:
            true, // This will clip the images to the container's shape
        boxFit: BoxFit.cover,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 1000),
      ),
    );
  }
}
