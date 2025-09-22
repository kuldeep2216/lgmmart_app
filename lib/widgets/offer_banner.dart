import 'package:flutter/material.dart';
import 'package:lgmmart_app/utils/app_theme.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Container with a BoxDecoration for the gradient and border radius
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColors.secondary, AppColors.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column for the text
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get 25% Off On Your First Order!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Use code WELCOME25 at checkout',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          // Button on the right
          ElevatedButton(
            onPressed: () {/* TODO: Add coupon logic */},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.light,
              foregroundColor: AppColors.secondary,
            ),
            child: const Text('Apply Code'),
          ),
        ],
      ),
    );
  }
}
