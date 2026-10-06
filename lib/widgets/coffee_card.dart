import 'package:flutter/material.dart';

import '../models/coffee.dart';
import '../screens/customer/product_details.dart';
import '../theme/app_theme.dart';
import 'price_widget.dart';
import 'rating_widget.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee? coffee;
  final String? name;
  final double? price;
  final double? rating;

  const CoffeeCard({
    super.key,
    this.coffee,
    this.name,
    this.price,
    this.rating,
  }) : assert(
          coffee != null || (name != null && price != null && rating != null),
          'Provide either a Coffee object or name/price/rating.',
        );

  @override
  Widget build(BuildContext context) {
    final itemName = coffee?.name ?? name ?? 'Coffee';
    final itemPrice = coffee?.price ?? price ?? 0.0;
    final itemRating = coffee?.rating ?? rating ?? 4.8;
    final imagePath = coffee?.image;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productName: itemName,
              price: itemPrice,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: imagePath != null
                    ? Image.asset(
                        imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.cream,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.coffee,
                          size: 55,
                          color: AppTheme.coffee,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              itemName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                RatingWidget(rating: itemRating),
                const Spacer(),
                PriceWidget(price: itemPrice),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
