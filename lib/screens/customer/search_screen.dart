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

  // ==========================================================
  // ALL PRODUCTS
  // ==========================================================

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

  // ==========================================================
  // POPULAR SEARCHES
  // ==========================================================

  final List<String> popularSearches = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cold Brew',
    'Mocha',
    'Americano',
  ];

  // ==========================================================
  // RECENT SEARCHES
  // ==========================================================

  final List<String> recentSearches = [
    'Velvet Espresso',
    'Italian Roast',
    'Caramel Macchiato',
  ];

  // ==========================================================
  // SEARCH RESULTS
  // ==========================================================

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

  // ==========================================================
  // OPEN PRODUCT
  // ==========================================================

  void openProduct(
    String name,
    double price,
  ) {
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

  // ==========================================================
  // SELECT SEARCH
  // ==========================================================

  void selectSearch(String text) {
    setState(() {
      searchController.text = text;

      searchController.selection = TextSelection.fromPosition(
        TextPosition(
          offset: searchController.text.length,
        ),
      );
    });
  }

  // ==========================================================
  // CLEAR SEARCH
  // ==========================================================

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final results = searchResults;

    final bool hasSearch = searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.cream,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: AppTheme.cream,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // SEARCH BOX
            // ==================================================

            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search coffee...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppTheme.coffee,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: clearSearch,
                        icon: const Icon(
                          Icons.close,
                        ),
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 25),

            // ==================================================
            // SEARCH RESULTS
            // ==================================================

            if (hasSearch) ...[
              Text(
                results.isEmpty
                    ? 'No Products Found'
                    : '${results.length} Product${results.length == 1 ? '' : 's'} Found',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 15),
              if (results.isEmpty)
                _noResults()
              else
                ...results.map(
                  (product) => _searchResultCard(product),
                ),
              const SizedBox(height: 20),
            ],

            // ==================================================
            // NORMAL CONTENT
            // ==================================================

            if (!hasSearch) ...[
              // ================================================
              // POPULAR SEARCHES
              // ================================================

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
                children: popularSearches.map(
                  (item) {
                    return ActionChip(
                      label: Text(item),
                      onPressed: () {
                        selectSearch(item);
                      },
                    );
                  },
                ).toList(),
              ),

              const SizedBox(height: 30),

              // ================================================
              // RECENT SEARCHES
              // ================================================

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
                  leading: const Icon(
                    Icons.history,
                    color: AppTheme.grey,
                  ),
                  title: Text(item),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                  onTap: () {
                    selectSearch(item);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ================================================
              // TRENDING TODAY
              // ================================================

              const Text(
                'Trending Today',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 15),

              // ================================================
              // TRENDING CARD
              // ================================================

              GestureDetector(
                onTap: () {
                  openProduct(
                    'Velvet Espresso',
                    279,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppTheme.coffeeDark,
                    borderRadius: BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Row(
                    children: [
                      // ========================================
                      // TRENDING IMAGE
                      // ========================================

                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        child: Image.asset(
                          'assets/images/velvet_espresso.jpg',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
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

                      const SizedBox(
                        width: 15,
                      ),

                      // ========================================
                      // TRENDING DETAILS
                      // ========================================

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
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              'Rich • Smooth • Premium',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
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
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SEARCH RESULT CARD
  // ==========================================================

  Widget _searchResultCard(
    Map<String, dynamic> product,
  ) {
    return GestureDetector(
      onTap: () {
        openProduct(
          product['name'].toString(),
          (product['price'] as num).toDouble(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 14,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            18,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.035,
              ),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // ==================================================
            // PRODUCT IMAGE
            // ==================================================

            ClipRRect(
              borderRadius: BorderRadius.circular(
                15,
              ),
              child: Image.asset(
                product['image'].toString(),
                height: 85,
                width: 85,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
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

            // ==================================================
            // PRODUCT INFO
            // ==================================================

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
                  const SizedBox(
                    height: 7,
                  ),
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

            // ==================================================
            // PRICE + ARROW
            // ==================================================

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
                const SizedBox(
                  height: 12,
                ),
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

  // ==========================================================
  // NO RESULTS
  // ==========================================================

  Widget _noResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off,
            size: 55,
            color: AppTheme.coffeeLight,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'No coffee found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
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
