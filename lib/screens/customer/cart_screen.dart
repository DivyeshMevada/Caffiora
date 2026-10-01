import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final String? addedProduct;
  final double? addedPrice;

  const CartScreen({
    super.key,
    this.addedProduct,
    this.addedPrice,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> items;

  final couponController = TextEditingController();

  @override
  void initState() {
    super.initState();

    items = [
      {
        'name': 'Italian Roast',
        'price': 249.0,
        'size': 'Medium',
        'milk': 'Whole Milk',
        'sugar': 'Regular',
        'quantity': 1,
      },
      {
        'name': 'Iced Latte',
        'price': 359.0,
        'size': 'Large',
        'milk': 'Whole Milk',
        'sugar': 'Less',
        'quantity': 1,
      },
    ];

    if (widget.addedProduct != null) {
      items.add({
        'name': widget.addedProduct!,
        'price': widget.addedPrice ?? 249,
        'size': 'Medium',
        'milk': 'Whole Milk',
        'sugar': 'Regular',
        'quantity': 1,
      });
    }
  }

  double get subtotal {
    double total = 0;

    for (final item in items) {
      total += (item['price'] as double) * (item['quantity'] as int);
    }

    return total;
  }

  double get deliveryFee {
    return items.isEmpty ? 0 : 60;
  }

  double get discount {
    return couponController.text.isNotEmpty ? 80 : 0;
  }

  double get total {
    return subtotal + deliveryFee - discount;
  }

  void applyCoupon() {
    if (couponController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter coupon code'),
        ),
      );
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coupon applied! ₹80 discount'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart (${items.length} Items)',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: items.isEmpty
          ? _emptyCart()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Review your items before checkout',
                    style: TextStyle(
                      color: AppTheme.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    items.length,
                    (index) => _cartItem(index),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Coupon Code',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: couponController,
                          decoration: const InputDecoration(
                            hintText: 'Enter coupon code',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: applyCoupon,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(90, 52),
                        ),
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  _orderSummary(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                              totalAmount: total,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  _benefits(),
                ],
              ),
            ),
    );
  }

  Widget _cartItem(int index) {
    final item = items[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85,
            width: 75,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.coffee,
              size: 40,
              color: AppTheme.coffee,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Size: ${item['size']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                Text(
                  'Milk: ${item['milk']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                Text(
                  'Sugar: ${item['sugar']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        if (item['quantity'] > 1) {
                          setState(() {
                            item['quantity']--;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item['quantity']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          item['quantity']++;
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 21,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '₹${((item['price'] as double) * (item['quantity'] as int)).toInt()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),
          const SizedBox(height: 15),
          _summaryRow(
            'Subtotal',
            '₹${subtotal.toInt()}',
          ),
          _summaryRow(
            'Delivery Fee',
            '₹${deliveryFee.toInt()}',
          ),
          _summaryRow(
            'Discount',
            '-₹${discount.toInt()}',
          ),
          const Divider(height: 25),
          _summaryRow(
            'Total',
            '₹${total.toInt()}',
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: bold ? AppTheme.coffeeDark : AppTheme.grey,
              fontWeight: bold ? FontWeight.bold : null,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.coffeeDark,
              fontWeight: bold ? FontWeight.bold : null,
              fontSize: bold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefits() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _Benefit(
          icon: Icons.verified_outlined,
          title: 'Premium Quality',
          subtitle: 'Finest Coffee Beans',
        ),
        _Benefit(
          icon: Icons.lock_outline,
          title: 'Secure Payment',
          subtitle: '100% Safe & Secure',
        ),
        _Benefit(
          icon: Icons.delivery_dining,
          title: 'Fast Delivery',
          subtitle: '20 - 25 mins',
        ),
      ],
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppTheme.coffeeLight,
          ),
          const SizedBox(height: 15),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _Benefit({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.coffee,
            size: 25,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.grey,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
