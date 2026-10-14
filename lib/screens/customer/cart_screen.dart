import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/cart_state.dart';
import 'checkout_screen.dart';
import 'menu_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onBrowseMenu;

  const CartScreen({
    super.key,
    this.onBrowseMenu,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final double deliveryFee = 60;
  final double discount = 80;

  int _totalItems(List<Map<String, dynamic>> items) {
    int count = 0;

    for (final item in items) {
      count += (item['quantity'] as int? ?? 1);
    }

    return count;
  }

  double _calculateSubtotal(List<Map<String, dynamic>> items) {
    double subtotal = 0;

    for (final item in items) {
      final double price = (item['price'] as num?)?.toDouble() ?? 0;

      final int quantity = (item['quantity'] as int?) ?? 1;

      subtotal += price * quantity;
    }

    return subtotal;
  }

  String _getProductImage(String name) {
    switch (name.toLowerCase()) {
      case 'italian roast':
        return 'assets/images/italian_roast.jpg';

      case 'caramel macchiato':
        return 'assets/images/caramel_macchiato.jpg';

      case 'velvet espresso':
        return 'assets/images/velvet_espresso.jpg';

      case 'velvet croissant':
        return 'assets/images/velvet_croissant.jpg';

      case 'cold brew':
        return 'assets/images/cold_brew.jpg';

      case 'stroopwafel cupcake':
        return 'assets/images/stroopwafel_cupcake.jpg';

      case 'iced latte':
        return 'assets/images/iced_latte.jpg';

      case 'iced matcha':
        return 'assets/images/iced_matcha.jpg';

      default:
        return 'assets/images/italian_roast.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // MAIN COLUMN
      body: Column(
        children: [
          // HEADER
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 16, 10),
              child: Row(
                children: [
                  // BACK BUTTON
                  IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppTheme.coffeeDark,
                      size: 25,
                    ),
                  ),

                  // MY CART TITLE
                  const Expanded(
                    child: Text(
                      'My Cart',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                  ),

                  // ITEM COUNT
                  ValueListenableBuilder<List<Map<String, dynamic>>>(
                    valueListenable: CartState.instance.items,
                    builder: (context, items, child) {
                      return Text(
                        '${_totalItems(items)} Items',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // SUBTITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Review your items before checkout',
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.grey,
                ),
              ),
            ),
          ),

          // EXPANDED CONTENT
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: CartState.instance.items,
              builder: (context, cartItems, child) {
                if (cartItems.isEmpty) {
                  return _emptyCart();
                }

                final double subtotal = _calculateSubtotal(cartItems);

                final double total = subtotal + deliveryFee - discount;

                return Column(
                  children: [
                    // SCROLLABLE CONTENT
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          15,
                          18,
                          15,
                          20,
                        ),
                        child: Column(
                          children: [
                            // CART PRODUCT CARDS
                            ...List.generate(
                              cartItems.length,
                              (index) {
                                return _cartItem(
                                  cartItems[index],
                                  index,
                                );
                              },
                            ),

                            const SizedBox(height: 20),

                            // ORDER SUMMARY
                            _orderSummary(subtotal, total),
                          ],
                        ),
                      ),
                    ),

                    // CHECKOUT BUTTON
                    _checkoutBottomBar(subtotal),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // CART PRODUCT CARD
  Widget _cartItem(
    Map<String, dynamic> item,
    int index,
  ) {
    final String name = item['name']?.toString() ?? '';
    final double price = (item['price'] as num?)?.toDouble() ?? 0;
    final int quantity = (item['quantity'] as int?) ?? 1;

    final String size = item['size']?.toString() ?? 'Medium';
    final String milk = item['milk']?.toString() ?? 'Whole Milk';
    final String sugar = item['sugar']?.toString() ?? 'Regular';

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              _getProductImage(name),
              width: 90,
              height: 105,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 105,
                  color: AppTheme.cream,
                  child: const Icon(
                    Icons.coffee,
                    size: 38,
                    color: AppTheme.coffeeDark,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // PRODUCT DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Size: $size',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),

                Text(
                  'Milk: $milk',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),

                Text(
                  'Sugar: $sugar',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '₹${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 10),

                // QUANTITY CONTROLS
                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        CartState.instance.decrement(index);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _quantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        CartState.instance.increment(index);
                      },
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        CartState.instance.remove(index);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      tooltip: 'Remove item',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // QUANTITY BUTTON
  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppTheme.cream,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.coffeeDark.withOpacity(0.15),
          ),
        ),
        child: Icon(
          icon,
          size: 17,
          color: AppTheme.coffeeDark,
        ),
      ),
    );
  }

  // ORDER SUMMARY
  Widget _orderSummary(
    double subtotal,
    double total,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 18),
          _summaryRow(
            'Subtotal',
            '₹${subtotal.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 12),
          _summaryRow(
            'Delivery Fee',
            '₹${deliveryFee.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 12),
          _summaryRow(
            'Discount',
            '-₹${discount.toStringAsFixed(0)}',
            valueColor: Colors.green,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1),
          ),
          _summaryRow(
            'Total',
            '₹${total.toStringAsFixed(0)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // SUMMARY ROW
  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.coffeeDark,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppTheme.coffeeDark,
          ),
        ),
      ],
    );
  }

  // CHECKOUT BUTTON
  Widget _checkoutBottomBar(double subtotal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  subtotalAmount: subtotal,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.coffeeDark,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // EMPTY CART
  Widget _emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(55),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 55,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Discover your favourite coffee and add it to your cart.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.grey,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onBrowseMenu != null) {
                    widget.onBrowseMenu!();
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.coffeeDark,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                  ),
                ),
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
