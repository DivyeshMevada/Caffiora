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
    final String productImage = getProductImage(widget.productName);

    return Scaffold(
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: AppTheme.grey,
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
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: addToCart,
                child: const Text(
                  'Add to Cart',
                ),
              ),
            ),
          ],
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
                errorBuilder: (context, error, stackTrace) {
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

            const SizedBox(height: 8),

            // ==================================================
            // RATING
            // ==================================================

            Row(
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text(
                  '4.9',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '(479 Reviews)',
                  style: TextStyle(
                    color: AppTheme.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

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
                  IconButton(
                    onPressed: decreaseQuantity,
                    icon: const Icon(
                      Icons.remove,
                    ),
                    color: AppTheme.coffeeDark,
                  ),
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
