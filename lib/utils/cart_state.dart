import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartState {
  CartState._();

  static final CartState instance = CartState._();

  // ==========================================================
  // CART ITEMS
  // ==========================================================

  final ValueNotifier<List<Map<String, dynamic>>> items =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  // ==========================================================
  // SHARED PREFERENCES KEY
  // ==========================================================

  static const String cartKey = 'caffiora_cart_items';

  // ==========================================================
  // ADD ITEM
  // ==========================================================

  void addItem({
    required String name,
    required double price,
    String size = 'Medium',
    String milk = 'Whole Milk',
    String sugar = 'Regular',
    int quantity = 1,
  }) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(items.value);

    // Check whether same product with same customization
    // already exists in cart.
    final int index = list.indexWhere(
      (item) =>
          item['name'] == name &&
          item['size'] == size &&
          item['milk'] == milk &&
          item['sugar'] == sugar,
    );

    if (index >= 0) {
      // Increase existing quantity
      list[index]['quantity'] = (list[index]['quantity'] as int) + quantity;
    } else {
      // Add new item
      list.add({
        'name': name,
        'price': price,
        'size': size,
        'milk': milk,
        'sugar': sugar,
        'quantity': quantity,
      });
    }

    // Update UI immediately
    items.value = list;

    // Save cart permanently
    _saveCart();
  }

  // ==========================================================
  // INCREMENT
  // ==========================================================

  void increment(int index) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(items.value);

    list[index]['quantity'] = (list[index]['quantity'] as int) + 1;

    items.value = list;

    _saveCart();
  }

  // ==========================================================
  // DECREMENT
  // ==========================================================

  void decrement(int index) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(items.value);

    final int quantity = (list[index]['quantity'] as int);

    if (quantity > 1) {
      list[index]['quantity'] = quantity - 1;
    }

    items.value = list;

    _saveCart();
  }

  // ==========================================================
  // REMOVE ITEM
  // ==========================================================

  void remove(int index) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(items.value);

    if (index >= 0 && index < list.length) {
      list.removeAt(index);
    }

    items.value = list;

    _saveCart();
  }

  // ==========================================================
  // CLEAR CART
  // ==========================================================

  void clear() {
    items.value = [];

    _saveCart();
  }

  // ==========================================================
  // SAVE CART
  // ==========================================================

  Future<void> _saveCart() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String encodedCart = jsonEncode(items.value);

      await prefs.setString(
        cartKey,
        encodedCart,
      );
    } catch (e) {
      debugPrint(
        'Cart save error: $e',
      );
    }
  }

  // ==========================================================
  // RESTORE CART
  // ==========================================================

  Future<void> restoreCart() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? savedCart = prefs.getString(cartKey);

      // No saved cart
      if (savedCart == null || savedCart.isEmpty) {
        items.value = [];
        return;
      }

      final dynamic decoded = jsonDecode(savedCart);

      if (decoded is List) {
        final List<Map<String, dynamic>> restoredItems = decoded
            .map(
              (item) => Map<String, dynamic>.from(
                item as Map,
              ),
            )
            .toList();

        items.value = restoredItems;
      } else {
        items.value = [];
      }
    } catch (e) {
      debugPrint(
        'Cart restore error: $e',
      );

      items.value = [];
    }
  }
}
