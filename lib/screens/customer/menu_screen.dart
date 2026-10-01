import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'product_details.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  final List<Map<String, dynamic>> products = const [
    {'name': 'Italian Roast', 'price': 249.0, 'rating': 4.9},
    {'name': 'Caramel Macchiato', 'price': 319.0, 'rating': 4.8},
    {'name': 'Velvet Espresso', 'price': 279.0, 'rating': 4.9},
    {'name': 'Velvet Croissant', 'price': 239.0, 'rating': 4.9},
    {'name': 'Cold Brew', 'price': 249.0, 'rating': 4.9},
    {'name': 'Stroopwafel Cupcake', 'price': 289.0, 'rating': 4.7},
    {'name': 'Iced Latte', 'price': 249.0, 'rating': 4.9},
    {'name': 'Iced Matcha', 'price': 349.0, 'rating': 4.8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _category('All', true),
                _category('Espresso Bar', false),
                _category('Bakery', false),
                _category('Cold Brew', false),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          productName: product['name'],
                          price: product['price'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.cream,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.coffee,
                              size: 60,
                              color: AppTheme.coffee,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          product['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coffeeDark,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '${product['rating']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.grey,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '₹${product['price'].toInt()}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.coffeeDark,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _category(String title, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: selected ? AppTheme.coffeeDark : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : AppTheme.coffeeDark,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
