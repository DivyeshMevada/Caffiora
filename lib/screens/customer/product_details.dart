import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final String productName;
  final double price;

  const ProductDetails({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String selectedSize = 'Medium';
  String selectedMilk = 'Whole Milk';
  String selectedSugar = 'Regular';

  int quantity = 1;

  double get totalPrice => widget.price * quantity;

  void addToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          addedProduct: widget.productName,
          addedPrice: totalPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total', style: TextStyle(color: AppTheme.grey)),
                  Text(
                    '₹${totalPrice.toInt()}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: addToCart,
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.coffeeLight,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(Icons.coffee, size: 110, color: Colors.white),
            ),

            const SizedBox(height: 25),

            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 5),
                Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('(479 Reviews)', style: TextStyle(color: AppTheme.grey)),
              ],
            ),

            const SizedBox(height: 15),

            Text(
              'Rich Italian roast with deep aroma, '
              'bold flavor, and a smooth finish. '
              'Crafted from premium Arabica beans.',
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.6,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            _sectionTitle('Size'),

            const SizedBox(height: 12),

            _selectionRow(
              options: ['Small 180ml', 'Medium 250ml', 'Large 400ml'],
              selected: selectedSize,
              onSelected: (value) {
                setState(() {
                  selectedSize = value;
                });
              },
            ),

            const SizedBox(height: 25),

            _sectionTitle('Milk'),

            const SizedBox(height: 12),

            _selectionRow(
              options: ['Whole Milk', 'Almond Milk', 'Oat Milk'],
              selected: selectedMilk,
              onSelected: (value) {
                setState(() {
                  selectedMilk = value;
                });
              },
            ),

            const SizedBox(height: 25),

            _sectionTitle('Sugar'),

            const SizedBox(height: 12),

            _selectionRow(
              options: ['None', 'Less', 'Regular', 'Extra'],
              selected: selectedSugar,
              onSelected: (value) {
                setState(() {
                  selectedSugar = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // Quantity
            Row(
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const Spacer(),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),

                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            const Text(
              'You may also like',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _suggestion('Iced Latte', 249),
                  _suggestion('Cappuccino', 319),
                  _suggestion('Velvet Croissant', 239),
                  _suggestion('Stroopwafel Cupcake', 289),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.coffeeDark,
      ),
    );
  }

  Widget _selectionRow({
    required List<String> options,
    required String selected,
    required Function(String) onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = selected == option;

        return GestureDetector(
          onTap: () => onSelected(option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.coffeeDark : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppTheme.coffeeDark : Colors.grey.shade300,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.coffeeDark,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _suggestion(String name, double price) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.coffee, color: AppTheme.coffee),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),

          Text(
            '₹${price.toInt()}',
            style: const TextStyle(
              color: AppTheme.coffeeDark,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
