import 'package:flutter/material.dart';
import 'package:lgmmart_app/models/product_model.dart';
import 'package:lgmmart_app/screens/product_detail_screen.dart';
import 'package:lgmmart_app/services/cart_service.dart';
import 'package:lgmmart_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Consumer rebuilds this widget when the cart changes for THIS specific product
    return Consumer<CartService>(
      builder: (context, cart, child) {
        int quantityInCart = cart.getQuantity(product.id);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  // THIS IS THE CORRECTED LINE
                  product: product,
                ),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.offer,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product Title Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.light.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.deliveryTime,
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        // Price and Button Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹${product.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    '₹${product.originalPrice.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: AppColors.gray,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                            // This switcher now correctly reflects the global cart state
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: quantityInCart == 0
                                  ? _buildAddButton(context)
                                  : _buildQuantityControls(
                                      context, quantityInCart),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- WIDGETS FOR BUTTONS ---

  Widget _buildAddButton(BuildContext context) {
    // Get the CartService to add items
    final cart = Provider.of<CartService>(context, listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      // **THE FIX IS HERE**: Call cart.addItem()
      onPressed: () => cart.addItem(product),
      child: const Text('Add'),
    );
  }

  Widget _buildQuantityControls(BuildContext context, int quantity) {
    // Get the CartService to modify items
    final cart = Provider.of<CartService>(context, listen: false);
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.remove, color: Colors.white, size: 16),
              // **THE FIX IS HERE**: Call cart.removeSingleItem()
              onPressed: () => cart.removeSingleItem(product.id),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: Colors.white, size: 16),
              // **THE FIX IS HERE**: Call cart.addItem()
              onPressed: () => cart.addItem(product),
            ),
          ),
        ],
      ),
    );
  }
}
