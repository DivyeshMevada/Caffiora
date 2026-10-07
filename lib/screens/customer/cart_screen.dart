import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/cart_state.dart';
import 'checkout_screen.dart';
import 'menu_screen.dart';

class CartScreen extends StatefulWidget {
  // ==========================================================
  // CALLBACK FOR BROWSE MENU
  // ==========================================================

  final VoidCallback? onBrowseMenu;

  const CartScreen({
    super.key,
    this.onBrowseMenu,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const double deliveryFee = 60.0;

  // Discount
  static const double discount = 80.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: AppTheme.cream,
        elevation: 0,
        title: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: CartState.instance.items,
          builder: (context, items, child) {
            return Text(
              'My Cart (${_totalItems(items)} Items)',
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            );
          },
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: CartState.instance.items,
        builder: (context, cartItems, child) {
          // ==================================================
          // EMPTY CART
          // ==================================================

          if (cartItems.isEmpty) {
            return _emptyCart();
          }

          // ==================================================
          // CALCULATIONS
          // ==================================================

          final double subtotal = _calculateSubtotal(cartItems);

          final double total = subtotal + deliveryFee - discount;

          // ==================================================
          // CART CONTENT
          // ==================================================

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    13,
                    15,
                    13,
                    20,
                  ),
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      child: Text(
                        'Review your items before checkout',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ==================================================
                    // CART ITEMS
                    // ==================================================

                    ...List.generate(
                      cartItems.length,
                      (index) {
                        return _cartItem(
                          cartItems[index],
                          index,
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    // ==================================================
                    // ORDER SUMMARY
                    // ==================================================

                    _orderSummary(
                      subtotal,
                      total,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // ==================================================
              // CHECKOUT BUTTON
              // ==================================================

              _checkoutBottomBar(
                subtotal,
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // CART ITEM
  // ==========================================================

  Widget _cartItem(
    Map<String, dynamic> item,
    int index,
  ) {
    final String name = item['name']?.toString() ?? '';

    final double price = (item['price'] as num?)?.toDouble() ?? 0;

    final int quantity = (item['quantity'] as num?)?.toInt() ?? 1;

    final String size = item['size']?.toString() ?? 'Medium';

    final String milk = item['milk']?.toString() ?? 'Whole Milk';

    final String sugar = item['sugar']?.toString() ?? 'Regular';

    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // PRODUCT IMAGE
          // ==================================================

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              _getProductImage(name),
              width: 92,
              height: 107,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  width: 92,
                  height: 107,
                  color: AppTheme.cream,
                  child: const Icon(
                    Icons.coffee,
                    size: 45,
                    color: AppTheme.coffee,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 16),

          // ==================================================
          // PRODUCT DETAILS
          // ==================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '₹${price.toInt()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  'Size: $size',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Milk: $milk',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Sugar: $sugar',
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                  ),
                ),

                const SizedBox(height: 14),

                // ==================================================
                // QUANTITY
                // ==================================================

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
                        horizontal: 13,
                      ),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                    ),

                    _quantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        CartState.instance.increment(index);
                      },
                    ),

                    const SizedBox(width: 16),

                    // DELETE
                    InkWell(
                      onTap: () {
                        CartState.instance.remove(index);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 27,
                        ),
                      ),
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

  // ==========================================================
  // QUANTITY BUTTON
  // ==========================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.coffeeDark,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: AppTheme.coffeeDark,
        ),
      ),
    );
  }

  // ==========================================================
  // ORDER SUMMARY
  // ==========================================================

  Widget _orderSummary(
    double subtotal,
    double total,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 28),
          _summaryRow(
            'Subtotal',
            subtotal,
          ),
          const SizedBox(height: 18),
          _summaryRow(
            'Delivery Fee',
            deliveryFee,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Discount',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              Text(
                '- ₹${discount.toInt()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 18,
            ),
            child: Divider(
              color: Color(0xFFE5E0DB),
            ),
          ),
          _summaryRow(
            'Total',
            total,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SUMMARY ROW
  // ==========================================================

  Widget _summaryRow(
    String title,
    double amount, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.coffeeDark,
          ),
        ),
        Text(
          '₹${amount.toInt()}',
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: AppTheme.coffeeDark,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // CHECKOUT BOTTOM BAR
  // ==========================================================

  Widget _checkoutBottomBar(
    double subtotal,
  ) {
    final double total = subtotal + deliveryFee - discount;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        18,
        15,
        18,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.08,
            ),
            blurRadius: 15,
            offset: const Offset(
              0,
              -4,
            ),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(
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
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '₹${total.toInt()}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY CART
  // ==========================================================

  Widget _emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CART ICON
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                color: AppTheme.cream,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 55,
                color: AppTheme.coffee,
              ),
            ),

            const SizedBox(height: 25),

            // TITLE
            const Text(
              'Your Cart is Empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            const Text(
              'Add your favourite coffee and\n'
              'delicious treats to your cart.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // BROWSE MENU
            // ==================================================

            ElevatedButton(
              onPressed: () {
                // IMPORTANT:
                // If HomeScreen callback exists,
                // open Menu tab of HomeScreen.
                if (widget.onBrowseMenu != null) {
                  widget.onBrowseMenu!();
                  return;
                }

                // Fallback if CartScreen is opened
                // independently.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 48),
              ),
              child: const Text(
                'Browse Menu',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TOTAL ITEMS
  // ==========================================================

  int _totalItems(
    List<Map<String, dynamic>> items,
  ) {
    int total = 0;

    for (final item in items) {
      total += (item['quantity'] as num?)?.toInt() ?? 1;
    }

    return total;
  }

  // ==========================================================
  // SUBTOTAL
  // ==========================================================

  double _calculateSubtotal(
    List<Map<String, dynamic>> items,
  ) {
    double subtotal = 0;

    for (final item in items) {
      final double price = (item['price'] as num?)?.toDouble() ?? 0;

      final int quantity = (item['quantity'] as num?)?.toInt() ?? 1;

      subtotal += price * quantity;
    }

    return subtotal;
  }

  // ==========================================================
  // PRODUCT IMAGES
  // ==========================================================

  String _getProductImage(
    String productName,
  ) {
    switch (productName) {
      case 'Italian Roast':
        return 'assets/images/italian_roast.jpg';

      case 'Caramel Macchiato':
        return 'assets/images/caramel_macchiato.jpg';

      case 'Velvet Espresso':
        return 'assets/images/velvet_espresso.jpg';

      case 'Velvet Croissant':
        return 'assets/images/velvet_croissant.jpg';

      case 'Cold Brew':
        return 'assets/images/cold_brew.jpg';

      case 'Stroopwafel Cupcake':
        return 'assets/images/stroopwafel_cupcake.jpg';

      case 'Iced Latte':
        return 'assets/images/iced_latte.jpg';

      case 'Iced Matcha':
        return 'assets/images/iced_matcha.jpg';

      default:
        return 'assets/images/italian_roast.jpg';
    }
  }
}
