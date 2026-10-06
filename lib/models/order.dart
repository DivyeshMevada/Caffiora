import 'cart_item.dart';

class Order {
  final String id;
  final String customerName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final List<CartItem> items;
  final double subtotal;
  final double total;

  const Order({
    required this.id,
    required this.customerName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.items,
    required this.subtotal,
    required this.total,
  });
}
