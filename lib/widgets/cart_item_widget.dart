import 'package:flutter/material.dart';

import '../data/cart_store.dart';
import '../models/cart_item.dart';
import '../theme/app_theme.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartStore.instance;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              item.coffee.image,
              height: 85,
              width: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.coffee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '₹${item.coffee.price.toInt()}',
                  style: const TextStyle(fontSize: 12, color: AppTheme.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => cart.decrease(index),
                      icon: const Icon(Icons.remove_circle_outline, size: 21),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => cart.increase(index),
                      icon: const Icon(Icons.add_circle_outline, size: 21),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => cart.remove(index),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '₹${item.lineTotal.toInt()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ],
      ),
    );
  }
}
