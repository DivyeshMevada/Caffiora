import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/cart_state.dart';
import 'cart_screen.dart';
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

  // ==========================================================
  // PRODUCTS
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
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.initialCategory;
  }

  // ==========================================================
  // FILTER PRODUCTS
  // ==========================================================

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

  // ==========================================================
  // CHANGE CATEGORY
  // ==========================================================

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // ==========================================================
  // OPEN PRODUCT DETAILS
  // ==========================================================

  void openProductDetails(
    Map<String, dynamic> product,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetails(
          productName: product['name'],
          price: product['price'],
        ),
      ),
    );
  }

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  void addToCart(
    Map<String, dynamic> product,
  ) {
    // Add product
    CartState.instance.addItem(
      name: product['name'],
      price: product['price'],
    );

    // Remove old snackbar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // ========================================================
    // SAME SNACKBAR AS PRODUCT DETAILS
    // ========================================================

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),

        behavior: SnackBarBehavior.floating,

        backgroundColor: AppTheme.coffeeDark,

        margin: const EdgeInsets.fromLTRB(
          8,
          0,
          8,
          12,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        content: Row(
          children: [
            // ==================================================
            // CHECK CIRCLE
            // ==================================================

            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppTheme.coffeeDark,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            // ==================================================
            // MESSAGE
            // ==================================================

            Expanded(
              child: Text(
                '${product['name']} added to cart',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        // ======================================================
        // VIEW CART
        // ======================================================

        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CartScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

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
        automaticallyImplyLeading: false,
        title: const Text(
          'Menu',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Column(
        children: [
          // ==================================================
          // CATEGORY FILTER
          // ==================================================

          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
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

          const SizedBox(height: 12),

          // ==================================================
          // PRODUCT GRID
          // ==================================================

          Expanded(
            child: filteredProducts.isEmpty
                ? _emptyFilterResult()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      20,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.68,
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

  // ==========================================================
  // PRODUCT CARD
  // ==========================================================

  Widget _productCard(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.045,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // PRODUCT IMAGE
          // ==================================================

          Expanded(
            child: GestureDetector(
              onTap: () {
                openProductDetails(product);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
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
          ),

          const SizedBox(height: 10),

          // ==================================================
          // PRODUCT NAME
          // ==================================================

          GestureDetector(
            onTap: () {
              openProductDetails(product);
            },
            child: Text(
              product['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),

          const SizedBox(height: 7),

          // ==================================================
          // PRICE
          // ==================================================

          Text(
            '₹${product['price'].toInt()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 9),

          // ==================================================
          // ADD TO CART BUTTON
          // ==================================================

          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                addToCart(product);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.coffeeDark,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 17,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CATEGORY BUTTON
  // ==========================================================

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
          horizontal: 22,
        ),
        decoration: BoxDecoration(
          color: selected ? AppTheme.coffeeDark : Colors.white,
          borderRadius: BorderRadius.circular(28),
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

  // ==========================================================
  // EMPTY FILTER RESULT
  // ==========================================================

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
            'No items available in '
            '$selectedCategory',
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
