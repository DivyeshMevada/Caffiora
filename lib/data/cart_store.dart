import 'package:flutter/foundation.dart';

import '../models/cart_item.dart';
import '../models/coffee.dart';

/// Simple shared cart using Flutter's built-in [ChangeNotifier].
class CartStore extends ChangeNotifier {
  CartStore._();

  static final CartStore instance = CartStore._();

  final List<CartItem> items = [];

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get deliveryFee => items.isEmpty ? 0 : 60;

  double get total => subtotal + deliveryFee;

  void add(
    Coffee coffee, {
    int quantity = 1,
    String size = 'Medium',
    String milk = 'Whole Milk',
    String sugar = 'Regular',
  }) {
    final index = items.indexWhere(
      (item) =>
          item.coffee.id == coffee.id &&
          item.size == size &&
          item.milk == milk &&
          item.sugar == sugar,
    );

    if (index >= 0) {
      items[index].quantity += quantity;
    } else {
      items.add(
        CartItem(
          coffee: coffee,
          quantity: quantity,
          size: size,
          milk: milk,
          sugar: sugar,
        ),
      );
    }
    notifyListeners();
  }

  void increase(int index) {
    items[index].quantity++;
    notifyListeners();
  }

  void decrease(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
    } else {
      items.removeAt(index);
    }
    notifyListeners();
  }

  void remove(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}
