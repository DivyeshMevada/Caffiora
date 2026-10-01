import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'order_success.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedAddress = 'Home';
  String selectedDelivery = 'Standard Delivery';
  String selectedPayment = 'Cash On Delivery';

  double get deliveryFee {
    if (selectedDelivery == 'Express Delivery') {
      return 80;
    }
    return 60;
  }

  double get subtotal {
    // PDF checkout screen uses ₹608 subtotal.
    return 608;
  }

  double get discount {
    return 80;
  }

  double get total {
    return subtotal + deliveryFee - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Almost there!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Complete Your Order',
                style: TextStyle(fontSize: 15, color: AppTheme.grey),
              ),

              const SizedBox(height: 28),

              // ---------------- DELIVERY ADDRESS ----------------
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 14),

              _addressCard(
                title: 'Raj Patel',
                address:
                    'Raj, Silver Stone St: 2,\nNana Mova Road, Rajkot, 360004',
                phone: '9798347684',
                type: 'Home',
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _addressTypeButton(
                      title: 'Home',
                      icon: Icons.home_outlined,
                      selected: selectedAddress == 'Home',
                      onTap: () {
                        setState(() {
                          selectedAddress = 'Home';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _addressTypeButton(
                      title: 'Work',
                      icon: Icons.work_outline,
                      selected: selectedAddress == 'Work',
                      onTap: () {
                        setState(() {
                          selectedAddress = 'Work';
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () {
                  _showAddAddressDialog();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.coffeeDark,
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: AppTheme.coffeeLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- DELIVERY OPTIONS ----------------
              const Text(
                'Delivery Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 14),

              _deliveryOption(
                title: 'Standard Delivery',
                subtitle: '20 - 25 mins',
                price: '₹60',
                value: 'Standard Delivery',
              ),

              const SizedBox(height: 12),

              _deliveryOption(
                title: 'Express Delivery',
                subtitle: '10 - 15 mins',
                price: '₹80',
                value: 'Express Delivery',
              ),

              const SizedBox(height: 30),

              // ---------------- PAYMENT METHODS ----------------
              const Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 14),

              _paymentOption(
                title: 'Cash On Delivery',
                icon: Icons.payments_outlined,
                value: 'Cash On Delivery',
              ),

              const SizedBox(height: 30),

              // ---------------- ORDER SUMMARY ----------------
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _summaryRow('Subtotal', '₹${subtotal.toStringAsFixed(0)}'),

                    const SizedBox(height: 12),

                    _summaryRow(
                      'Delivery Fee',
                      '₹${deliveryFee.toStringAsFixed(0)}',
                    ),

                    const SizedBox(height: 12),

                    _summaryRow(
                      'Discount',
                      '-₹${discount.toStringAsFixed(0)}',
                      valueColor: Colors.green,
                    ),

                    const Divider(height: 28),

                    _summaryRow(
                      'Total',
                      '₹${total.toStringAsFixed(0)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- PLACE ORDER ----------------
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderSuccessScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Proceed to Checkout • ₹${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- TRUST INFORMATION ----------------
              Row(
                children: [
                  Expanded(
                    child: _trustItem(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Premium Quality',
                      subtitle: 'Finest Coffee Beans',
                    ),
                  ),
                  Expanded(
                    child: _trustItem(
                      icon: Icons.lock_outline,
                      title: 'Secure Payment',
                      subtitle: '100% Safe & Secure',
                    ),
                  ),
                  Expanded(
                    child: _trustItem(
                      icon: Icons.delivery_dining_outlined,
                      title: 'Fast Delivery',
                      subtitle: '20 - 25 mins',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // ADDRESS CARD
  // ----------------------------------------------------------

  Widget _addressCard({
    required String title,
    required String address,
    required String phone,
    required String type,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.coffeeLight.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: AppTheme.coffee),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showChangeAddressDialog();
                },
                child: const Text('Change'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            address,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.grey,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            phone,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.coffeeDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // ADDRESS TYPE
  // ----------------------------------------------------------

  Widget _addressTypeButton({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppTheme.coffeeDark : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppTheme.coffeeDark : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: selected ? Colors.white : AppTheme.coffeeDark,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : AppTheme.coffeeDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // DELIVERY OPTION
  // ----------------------------------------------------------

  Widget _deliveryOption({
    required String title,
    required String subtitle,
    required String price,
    required String value,
  }) {
    final bool selected = selectedDelivery == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedDelivery = value;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.coffee : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: selectedDelivery,
              activeColor: AppTheme.coffee,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedDelivery = value;
                  });
                }
              },
            ),

            const SizedBox(width: 5),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: AppTheme.grey),
                  ),
                ],
              ),
            ),

            Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // PAYMENT OPTION
  // ----------------------------------------------------------

  Widget _paymentOption({
    required String title,
    required IconData icon,
    required String value,
  }) {
    final bool selected = selectedPayment == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.coffee : Colors.grey.shade300,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.coffee),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ),

            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              activeColor: AppTheme.coffee,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPayment = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // SUMMARY ROW
  // ----------------------------------------------------------

  Widget _summaryRow(
    String title,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppTheme.coffeeDark : AppTheme.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppTheme.coffeeDark,
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // TRUST ITEM
  // ----------------------------------------------------------

  Widget _trustItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.coffee, size: 24),

          const SizedBox(height: 7),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, color: AppTheme.grey),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // ADD ADDRESS DIALOG
  // ----------------------------------------------------------

  void _showAddAddressDialog() {
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Address'),
          content: TextField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Enter your address'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Address added successfully')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // CHANGE ADDRESS DIALOG
  // ----------------------------------------------------------

  void _showChangeAddressDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Address'),
          content: const Text('Choose another saved address for delivery.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Address selection opened')),
                );
              },
              child: const Text('Choose'),
            ),
          ],
        );
      },
    );
  }
}
