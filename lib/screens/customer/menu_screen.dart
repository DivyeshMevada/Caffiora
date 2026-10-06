import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'product_details.dart';

class MenuScreen extends StatefulWidget {
  final String initialCategory;

  const MenuScreen({
    super.key,
    this.initialCategory = 'All',
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Italian Roast',
      'price': 249.0,
      'rating': 4.9,
      'category': 'Espresso Bar',
      'image': 'assets/images/italian_roast.jpg',
    },
    {
      'name': 'Caramel Macchiato',
      'price': 319.0,
      'rating': 4.8,
      'category': 'Espresso Bar',
      'image': 'assets/images/caramel_macchiato.jpg',
    },
    {
      'name': 'Velvet Espresso',
      'price': 279.0,
      'rating': 4.9,
      'category': 'Espresso Bar',
      'image': 'assets/images/velvet_espresso.jpg',
    },
    {
      'name': 'Velvet Croissant',
      'price': 239.0,
      'rating': 4.9,
      'category': 'Bakery',
      'image': 'assets/images/velvet_croissant.jpg',
    },
    {
      'name': 'Cold Brew',
      'price': 249.0,
      'rating': 4.9,
      'category': 'Cold Brew',
      'image': 'assets/images/cold_brew.jpg',
    },
    {
      'name': 'Stroopwafel Cupcake',
      'price': 289.0,
      'rating': 4.7,
      'category': 'Bakery',
      'image': 'assets/images/stroopwafel_cupcake.jpg',
    },
    {
      'name': 'Iced Latte',
      'price': 249.0,
      'rating': 4.9,
      'category': 'Cold Brew',
      'image': 'assets/images/iced_latte.jpg',
    },
    {
      'name': 'Iced Matcha',
      'price': 349.0,
      'rating': 4.8,
      'category': 'Cold Brew',
      'image': 'assets/images/iced_matcha.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory;
  }

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return products;
    }

    return products
        .where(
          (product) => product['category'] == selectedCategory,
        )
        .toList();
  }

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // CATEGORY FILTER
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              children: [
                _category(
                  'All',
                  selectedCategory == 'All',
                ),
                _category(
                  'Espresso Bar',
                  selectedCategory == 'Espresso Bar',
                ),
                _category(
                  'Bakery',
                  selectedCategory == 'Bakery',
                ),
                _category(
                  'Cold Brew',
                  selectedCategory == 'Cold Brew',
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // PRODUCT GRID
          Expanded(
            child: filteredProducts.isEmpty
                ? _emptyFilterResult()
                : GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return _productCard(
                        context,
                        product,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
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
            // PRODUCT IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  product['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      color: AppTheme.cream,
                      child: const Icon(
                        Icons.coffee,
                        size: 60,
                        color: AppTheme.coffee,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // PRODUCT NAME
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

            // RATING + PRICE
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
  }

  Widget _category(
    String title,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () {
        changeCategory(title);
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
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
      ),
    );
  }

  Widget _emptyFilterResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.coffee_outlined,
            size: 70,
            color: AppTheme.coffeeLight,
          ),
          const SizedBox(height: 15),
          const Text(
            'No products found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No items available in $selectedCategory',
            style: const TextStyle(
              color: AppTheme.grey,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              changeCategory('All');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 45),
            ),
            child: const Text(
              'View All Products',
            ),
          ),
        ],
      ),
    );
  }
}
