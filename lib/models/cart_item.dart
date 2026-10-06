import 'coffee.dart';

class CartItem {
  final Coffee coffee;
  int quantity;
  final String size;
  final String milk;
  final String sugar;

  CartItem({
    required this.coffee,
    this.quantity = 1,
    this.size = 'Medium',
    this.milk = 'Whole Milk',
    this.sugar = 'Regular',
  });

  double get lineTotal => coffee.price * quantity;
}
