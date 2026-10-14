import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Italian Roast',
      'price': 249.0,
      'category': 'Espresso Bar',
      'image': 'assets/images/italian_roast.jpg',
    },
    {
      'name': 'Caramel Macchiato',
      'price': 319.0,
      'category': 'Espresso Bar',
      'image': 'assets/images/caramel_macchiato.jpg',
    },
    {
      'name': 'Velvet Espresso',
      'price': 279.0,
      'category': 'Espresso Bar',
      'image': 'assets/images/velvet_espresso.jpg',
    },
    {
      'name': 'Velvet Croissant',
      'price': 239.0,
      'category': 'Bakery',
      'image': 'assets/images/velvet_croissant.jpg',
    },
    {
      'name': 'Cold Brew',
      'price': 249.0,
      'category': 'Cold Brew',
      'image': 'assets/images/cold_brew.jpg',
    },
    {
      'name': 'Stroopwafel Cupcake',
      'price': 289.0,
      'category': 'Bakery',
      'image': 'assets/images/stroopwafel_cupcake.jpg',
    },
    {
      'name': 'Iced Latte',
      'price': 249.0,
      'category': 'Cold Brew',
      'image': 'assets/images/iced_latte.jpg',
    },
    {
      'name': 'Iced Matcha',
      'price': 349.0,
      'category': 'Cold Brew',
      'image': 'assets/images/iced_matcha.jpg',
    },
  ];

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

  List<Map<String, dynamic>> get searchResults {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return [];
    }

    return products.where((product) {
      final name = product['name'].toString().toLowerCase();
      final category = product['category'].toString().toLowerCase();

      return name.contains(query) || category.contains(query);
    }).toList();
  }

  void openProduct(String name, double price) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(
          productName: name,
          price: price,
        ),
      ),
    );
  }

  void selectSearch(String text) {
    setState(() {
      searchController.text = text;
      searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = searchResults;
    final hasSearch = searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Column(
          children: [
            // APP BAR
            AppBar(
              backgroundColor: AppTheme.cream,
              elevation: 0,
              automaticallyImplyLeading: true,
              title: const Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search coffee...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppTheme.coffee,
                  ),
                  suffixIcon: hasSearch
                      ? IconButton(
                          onPressed: clearSearch,
                          icon: const Icon(Icons.close),
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CONTENT
            Expanded(
              child: hasSearch
                  ? _buildSearchResults(results)
                  : _buildNormalContent(),
            ),
          ],
        ),
      ),
    );
  }

  // SEARCH RESULTS WITH LISTVIEW
  Widget _buildSearchResults(
    List<Map<String, dynamic>> results,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PRODUCTS FOUND TEXT
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Text(
            results.isEmpty
                ? 'No Products Found'
                : '${results.length} Product${results.length == 1 ? '' : 's'} Found',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ),

        // PRODUCT LIST
        Expanded(
          child: results.isEmpty
              ? SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: _noResults(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    20,
                  ),
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return _searchResultCard(results[index]);
                  },
                ),
        ),
      ],
    );
  }

  // NORMAL CONTENT
  Widget _buildNormalContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // POPULAR SEARCHES
          const Text(
            'Popular Searches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 15),

          // SEARCH CHIPS
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: popularSearches.map((item) {
              return ActionChip(
                label: Text(item),
                backgroundColor: Colors.white,
                labelStyle: const TextStyle(
                  color: AppTheme.coffeeDark,
                ),
                onPressed: () => selectSearch(item),
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // RECENT SEARCHES
          const Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 10),

          // SEARCH LIST
          ...recentSearches.map((item) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.history,
                color: AppTheme.grey,
              ),
              title: Text(item),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () => selectSearch(item),
            );
          }),

          const SizedBox(height: 20),

          // TRENDING TODAY
          const Text(
            'Trending Today',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 15),

          // TRENDING PRODUCT CARD
          GestureDetector(
            onTap: () {
              openProduct('Velvet Espresso', 279.0);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppTheme.coffeeDark,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/velvet_espresso.jpg',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 80,
                          width: 80,
                          color: AppTheme.coffeeLight,
                          child: const Icon(
                            Icons.coffee,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
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
    );
  }

  // SEARCH RESULT CARD
  Widget _searchResultCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        openProduct(
          product['name'].toString(),
          (product['price'] as num).toDouble(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // PRODUCT IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                product['image'].toString(),
                height: 85,
                width: 85,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 85,
                    width: 85,
                    color: AppTheme.cream,
                    child: const Icon(
                      Icons.coffee,
                      size: 42,
                      color: AppTheme.coffee,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 14),

            // PRODUCT NAME AND CATEGORY
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    product['category'].toString(),
                    style: const TextStyle(
                      color: AppTheme.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // PRICE AND ARROW
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${(product['price'] as num).toInt()}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 12),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: AppTheme.coffee,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // NO RESULTS
  Widget _noResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.search_off,
            size: 55,
            color: AppTheme.coffeeLight,
          ),
          SizedBox(height: 15),
          Text(
            'No coffee found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching for another coffee.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
