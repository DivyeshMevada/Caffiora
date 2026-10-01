import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();

  final List<String> popularSearches = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cold Brew',
    'Mocha',
    'Americano',
  ];

  final List<String> recentSearches = [
    'Velvet Espresso',
    'Italian Roast',
    'Caramel Macchiato',
  ];

  void openProduct(String name, double price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(productName: name, price: price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search box
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search coffee...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  openProduct(value.trim(), 249);
                }
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: popularSearches.map((item) {
                return ActionChip(
                  label: Text(item),
                  onPressed: () {
                    searchController.text = item;
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 10),

            ...recentSearches.map(
              (item) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history, color: AppTheme.grey),
                title: Text(item),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {
                  searchController.text = item;
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Trending Today',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: () {
                openProduct('Velvet Espresso', 279);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.coffeeDark,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: AppTheme.coffeeLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.coffee,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Velvet Espresso',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Rich • Smooth • Premium',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₹279',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
