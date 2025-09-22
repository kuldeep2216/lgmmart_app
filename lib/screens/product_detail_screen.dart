import 'package:flutter/material.dart';
import 'package:lgmmart_app/utils/app_theme.dart'; // Import your theme

class ProductDetailScreen extends StatefulWidget {
  // We will pass this data from the ProductCard
  final String imageUrl;
  final String title;
  final double price;

  const ProductDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // State variables to manage UI changes
  late String _selectedImageUrl;
  int _quantity = 1;

  // Mock data for other thumbnail images
  final List<String> _thumbnailImages = [
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1080-1080,pr-true,f-auto,q-80/cms/product_variant/4040202b-0bd1-48f9-bcbb-eb2e6c3d6cb3/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-2000-2000,pr-true,f-auto,q-80/cms/product_variant/7bbbb1d2-c128-4e73-ac13-bbdce42b2675/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1500-1500,pr-true,f-auto,q-80/cms/product_variant/ff72cb0d-b132-4c7d-9969-e57bad73c90b/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1080-1080,pr-true,f-auto,q-80/cms/product_variant/a111d282-a963-40f5-9e50-b35ab813bfd1/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    // Initially, the selected image is the one passed to the widget
    _selectedImageUrl = widget.imageUrl;
    // Add the main image to the list if it's not already there
    if (!_thumbnailImages.contains(_selectedImageUrl)) {
      _thumbnailImages.insert(0, _selectedImageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- IMAGE GALLERY ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Main Image
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(_selectedImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Thumbnails
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _thumbnailImages.length,
                      itemBuilder: (context, index) {
                        final imageUrl = _thumbnailImages[index];
                        final isSelected = imageUrl == _selectedImageUrl;
                        return GestureDetector(
                          onTap: () {
                            // When a thumbnail is tapped, update the state
                            setState(() {
                              _selectedImageUrl = imageUrl;
                            });
                          },
                          child: Container(
                            width: 70,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // --- PRODUCT INFO ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By Fresh Farms Organics',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '₹${widget.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Our organic produce is grown without synthetic pesticides and fertilizers. Rich in potassium, fiber, and natural sugars, they are perfectly ripe and ready to eat.',
                    style: TextStyle(
                        fontSize: 16, height: 1.5, color: AppColors.dark),
                  ),
                  const SizedBox(height: 24),

                  // --- QUANTITY SELECTOR ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5)
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove,
                                  color: AppColors.primary),
                              onPressed: () {
                                setState(() {
                                  if (_quantity > 1) _quantity--;
                                });
                              },
                            ),
                            Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add,
                                  color: AppColors.primary),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100), // Spacer for the button
          ],
        ),
      ),
      // --- ADD TO CART BUTTON ---
      // This is a common pattern for a button that sticks to the bottom
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Add To Cart'),
        ),
      ),
    );
  }
}
