import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lgmmart_app/services/cart_service.dart';
import 'package:lgmmart_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

enum PaymentMethod { card, wallet, cash }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedAddressIndex = 0;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: cart.items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Text('Your Cart is Empty',
                          style: TextStyle(fontSize: 20)),
                      Text('Add some items to see them here.',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 7, child: _buildFormsColumn()),
                          Expanded(flex: 5, child: _buildOrderSummary(cart)),
                        ],
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildOrderSummary(cart),
                            _buildFormsColumn(),
                          ],
                        ),
                      );
                    }
                  },
                ),
          bottomNavigationBar:
              cart.items.isNotEmpty ? _buildPlaceOrderButton(cart) : null,
        );
      },
    );
  }

  Widget _buildFormsColumn() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      child: Column(
        children: [
          _buildDeliveryAddressCard(),
          const SizedBox(height: 20),
          _buildPaymentCard(),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartService cart) {
    const double deliveryFee = 30.0;
    const double tax = 20.0;
    final double total = cart.totalPrice + deliveryFee + tax;

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            // Dynamically build the list of items from the cart
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items.values.toList()[index];
                return _buildProductItem(item);
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
            const Divider(height: 24),
            _buildSummaryRow(
                'Subtotal', '₹${cart.totalPrice.toStringAsFixed(0)}'),
            _buildSummaryRow(
                'Delivery Fee', '₹${deliveryFee.toStringAsFixed(0)}'),
            _buildSummaryRow('Tax', '₹${tax.toStringAsFixed(0)}'),
            const Divider(height: 24),
            _buildSummaryRow('Total', '₹${total.toStringAsFixed(0)}',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(CartItem item) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(item.product.imageUrl,
            width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(item.product.title),
      subtitle: Text('Quantity: ${item.quantity}'),
      trailing:
          Text('₹${(item.product.price * item.quantity).toStringAsFixed(0)}'),
    );
  }

  Widget _buildDeliveryAddressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Address',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('Add')),
              ],
            ),
            const Divider(height: 24),
            RadioListTile(
              value: 0,
              groupValue: _selectedAddressIndex,
              onChanged: (val) => setState(() => _selectedAddressIndex = val!),
              title: const Text('John Doe'),
              subtitle: const Text('123 Main Street, City, ZIP'),
            ),
            RadioListTile(
              value: 1,
              groupValue: _selectedAddressIndex,
              onChanged: (val) => setState(() => _selectedAddressIndex = val!),
              title: const Text('Jane Smith'),
              subtitle: const Text('456 Park Avenue, City, ZIP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildPaymentOption(
                    icon: FontAwesomeIcons.creditCard,
                    label: 'Card',
                    method: PaymentMethod.card),
                const SizedBox(width: 12),
                _buildPaymentOption(
                    icon: FontAwesomeIcons.wallet,
                    label: 'Wallet',
                    method: PaymentMethod.wallet),
                const SizedBox(width: 12),
                _buildPaymentOption(
                    icon: FontAwesomeIcons.moneyBillWave,
                    label: 'COD',
                    method: PaymentMethod.cash),
              ],
            ),
            if (_selectedPaymentMethod == PaymentMethod.card) _buildCardForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(labelText: 'Card Number')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Expiry Date'))),
              const SizedBox(width: 12),
              Expanded(
                  child: TextFormField(
                      decoration: const InputDecoration(labelText: 'CVV'))),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
              decoration: const InputDecoration(labelText: 'Name on Card')),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(CartService cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onPressed: () {
          // Show a confirmation and clear the cart
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order Placed Successfully!')),
          );
          cart.clearCart();
          Navigator.of(context).pop(); // Go back to the previous screen
        },
        child: const Text('Place Order'),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(amount,
            style: TextStyle(
                fontSize: isTotal ? 18 : 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildPaymentOption(
      {required IconData icon,
      required String label,
      required PaymentMethod method}) {
    final bool isSelected = _selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = method),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[300]!),
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              FaIcon(icon,
                  color: isSelected ? AppColors.primary : AppColors.gray),
              const SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
