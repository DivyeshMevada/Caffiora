import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/cart_state.dart';
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

  // ==========================================================
  // PRODUCT IMAGE
  // ==========================================================

  String getProductImage(String productName) {
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
        return 'assets/images/velvet_espresso.jpg';
    }
  }

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  void addToCart() {
    CartState.instance.addItem(
      name: widget.productName,
      price: widget.price,
      size: selectedSize,
      milk: selectedMilk,
      sugar: selectedSugar,
      quantity: quantity,
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: AppTheme.coffeeDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${widget.productName} added to cart',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
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
  // QUANTITY
  // ==========================================================

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final String productImage = getProductImage(
      widget.productName,
    );

    return Scaffold(
      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ======================================================
      // BOTTOM ADD TO CART
      // ======================================================

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          20,
        ),
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // ==================================================
              // TOTAL PRICE
              // ==================================================

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 13,
                      ),
                    ),
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

              // ==================================================
              // ADD TO CART BUTTON
              // ==================================================

              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.coffeeDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 20,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
            // PRODUCT IMAGE
            // ==================================================

            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                productImage,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.coffeeLight,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.coffee,
                      size: 110,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // PRODUCT NAME
            // ==================================================

            Text(
              widget.productName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            // ==================================================
            // PRICE
            // ==================================================

            Text(
              '₹${widget.price.toInt()}',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffee,
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // DESCRIPTION
            // ==================================================

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

            const SizedBox(height: 25),

            // ==================================================
            // SIZE
            // ==================================================

            const Text(
              'Size',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _optionButton(
                  title: 'Small',
                  selected: selectedSize == 'Small',
                  onTap: () {
                    setState(() {
                      selectedSize = 'Small';
                    });
                  },
                ),
                const SizedBox(width: 10),
                _optionButton(
                  title: 'Medium',
                  selected: selectedSize == 'Medium',
                  onTap: () {
                    setState(() {
                      selectedSize = 'Medium';
                    });
                  },
                ),
                const SizedBox(width: 10),
                _optionButton(
                  title: 'Large',
                  selected: selectedSize == 'Large',
                  onTap: () {
                    setState(() {
                      selectedSize = 'Large';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // MILK
            // ==================================================

            const Text(
              'Milk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _optionButton(
                  title: 'Whole Milk',
                  selected: selectedMilk == 'Whole Milk',
                  onTap: () {
                    setState(() {
                      selectedMilk = 'Whole Milk';
                    });
                  },
                ),
                _optionButton(
                  title: 'Almond Milk',
                  selected: selectedMilk == 'Almond Milk',
                  onTap: () {
                    setState(() {
                      selectedMilk = 'Almond Milk';
                    });
                  },
                ),
                _optionButton(
                  title: 'Oat Milk',
                  selected: selectedMilk == 'Oat Milk',
                  onTap: () {
                    setState(() {
                      selectedMilk = 'Oat Milk';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // SUGAR
            // ==================================================

            const Text(
              'Sugar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _optionButton(
                  title: 'Regular',
                  selected: selectedSugar == 'Regular',
                  onTap: () {
                    setState(() {
                      selectedSugar = 'Regular';
                    });
                  },
                ),
                _optionButton(
                  title: 'Less',
                  selected: selectedSugar == 'Less',
                  onTap: () {
                    setState(() {
                      selectedSugar = 'Less';
                    });
                  },
                ),
                _optionButton(
                  title: 'No Sugar',
                  selected: selectedSugar == 'No Sugar',
                  onTap: () {
                    setState(() {
                      selectedSugar = 'No Sugar';
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // QUANTITY
            // ==================================================

            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // MINUS
                  IconButton(
                    onPressed: decreaseQuantity,
                    icon: const Icon(
                      Icons.remove,
                    ),
                    color: AppTheme.coffeeDark,
                  ),

                  // NUMBER
                  Container(
                    width: 35,
                    alignment: Alignment.center,
                    child: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // PLUS
                  IconButton(
                    onPressed: increaseQuantity,
                    icon: const Icon(
                      Icons.add,
                    ),
                    color: AppTheme.coffeeDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // OPTION BUTTON
  // ==========================================================

  Widget _optionButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected ? AppTheme.coffeeDark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppTheme.coffeeDark : Colors.grey.shade300,
          ),
        ),
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
