import 'package:flutter/foundation.dart';

class CartState {
  CartState._();

  static final CartState instance = CartState._();

  final ValueNotifier<List<Map<String, dynamic>>> items =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  void addItem({
    required String name,
    required double price,
    String size = 'Medium',
    String milk = 'Whole Milk',
    String sugar = 'Regular',
    int quantity = 1,
  }) {
    final list = List<Map<String, dynamic>>.from(items.value);

    final index = list.indexWhere(
      (item) =>
          item['name'] == name &&
          item['size'] == size &&
          item['milk'] == milk &&
          item['sugar'] == sugar,
    );

    if (index != -1) {
      list[index]['quantity'] = (list[index]['quantity'] as int) + quantity;
    } else {
      list.add({
        'name': name,
        'price': price,
        'size': size,
        'milk': milk,
        'sugar': sugar,
        'quantity': quantity,
      });
    }

    items.value = list;
  }

  void increment(int index) {
    final list = List<Map<String, dynamic>>.from(items.value);

    list[index]['quantity'] = (list[index]['quantity'] as int) + 1;

    items.value = list;
  }

  void decrement(int index) {
    final list = List<Map<String, dynamic>>.from(items.value);

    final quantity = list[index]['quantity'] as int;

    if (quantity > 1) {
      list[index]['quantity'] = quantity - 1;
    }

    items.value = list;
  }

  void remove(int index) {
    final list = List<Map<String, dynamic>>.from(items.value);

    list.removeAt(index);

    items.value = list;
  }

  void clear() {
    items.value = [];
  }
}
