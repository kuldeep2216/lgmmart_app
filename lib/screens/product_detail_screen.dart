import 'package:flutter/material.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/services/cart_service.dart';
import 'package:lgmmart_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  // It now accepts a single, complete Product object.
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _selectedImageUrl;

  // Mock data for other thumbnail images - can be expanded later
  final List<String> _thumbnailImages = [
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-2000-2000,pr-true,f-auto,q-80/cms/product_variant/7bbbb1d2-c128-4e73-ac13-bbdce42b2675/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1500-1500,pr-true,f-auto,q-80/cms/product_variant/ff72cb0d-b132-4c7d-9969-e57bad73c90b/Plix-The-Plant-Fix-Rosemary-Advanced-Hair-Growth-Serum-Reduces-Hair-Fall-Promotes-Hair-Growth.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    _selectedImageUrl = widget.product.imageUrl;
    if (!_thumbnailImages.contains(_selectedImageUrl)) {
      _thumbnailImages.insert(0, _selectedImageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a Consumer to listen for changes in the CartService
    return Consumer<CartService>(
      builder: (context, cart, child) {
        final quantityInCart = cart.getQuantity(widget.product.id);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Details'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageGallery(),
                _buildProductInfo(),
                _buildQuantitySelector(cart, quantityInCart),
                const SizedBox(height: 120), // Spacer for the bottom button
              ],
            ),
          ),
          bottomSheet: _buildAddToCartButton(cart, quantityInCart),
        );
      },
    );
  }

  // --- UI HELPER WIDGETS ---

  Widget _buildImageGallery() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(_selectedImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _thumbnailImages.length,
              itemBuilder: (context, index) {
                final imageUrl = _thumbnailImages[index];
                final isSelected = imageUrl == _selectedImageUrl;
                return GestureDetector(
                  onTap: () => setState(() => _selectedImageUrl = imageUrl),
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
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
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.product.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('By Fresh Farms Organics',
              style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 16),
          Text('₹${widget.product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary)),
          const SizedBox(height: 16),
          const Text(
              'Our organic produce is grown without synthetic pesticides...',
              style:
                  TextStyle(fontSize: 16, height: 1.5, color: AppColors.dark)),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(CartService cart, int quantityInCart) {
    if (quantityInCart == 0) {
      return const SizedBox.shrink(); // Return an empty widget if not in cart
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Quantity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.primary),
                  onPressed: () => cart.removeSingleItem(widget.product.id),
                ),
                Text(quantityInCart.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add, color: AppColors.primary),
                  onPressed: () => cart.addItem(widget.product),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton(CartService cart, int quantityInCart) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () => cart.addItem(widget.product),
        child: Text(quantityInCart > 0 ? 'Add Another' : 'Add To Cart'),
      ),
    );
  }
}
