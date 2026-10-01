import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class StaffOrderDetails extends StatefulWidget {
  final Map<String, dynamic> order;

  const StaffOrderDetails({super.key, required this.order});

  @override
  State<StaffOrderDetails> createState() => _StaffOrderDetailsState();
}

class _StaffOrderDetailsState extends State<StaffOrderDetails> {
  late String status;

  @override
  void initState() {
    super.initState();

    status = widget.order['status'] ?? 'Preparing';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _orderHeader(),

            const SizedBox(height: 20),

            _customerSection(),

            const SizedBox(height: 20),

            const Text(
              'Order Items',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            _itemCard('Velvet Espresso', 'Premium espresso', 349),

            const SizedBox(height: 10),

            _itemCard('Iced Matcha', 'Refreshing iced matcha', 279),

            const SizedBox(height: 20),

            _priceSummary(),

            const SizedBox(height: 22),

            _statusSelector(),

            const SizedBox(height: 20),

            if (status == 'Preparing')
              _actionButton('Mark as Ready', () => _updateStatus('Ready'))
            else if (status == 'Ready')
              _actionButton(
                'Mark as Completed',
                () => _updateStatus('Completed'),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, status);
                  },
                  child: const Text('Order Completed'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _orderHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.coffeeDark,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.order['id'] ?? '#CF-134',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  '09:42 AM',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          _statusBadge(status),
        ],
      ),
    );
  }

  Widget _customerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, color: AppTheme.coffee),
          ),
          const SizedBox(width: 13),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CUSTOMER',
                style: TextStyle(
                  fontSize: 10,
                  color: AppTheme.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'RAJIV KUMAR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemCard(String name, String description, int price) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.local_cafe_outlined,
              color: AppTheme.coffee,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11, color: AppTheme.grey),
                ),
              ],
            ),
          ),
          Text(
            '₹$price',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        children: [
          _priceRow('Subtotal', '₹628'),
          const SizedBox(height: 12),
          _priceRow('ST. Delivery', '₹60'),
          const SizedBox(height: 13),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 13),
          _priceRow('Total', '₹688', bold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: bold ? 15 : 13,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: bold ? AppTheme.coffeeDark : AppTheme.grey,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ],
    );
  }

  Widget _statusSelector() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Status',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _statusChip('Preparing'),
              _statusChip('Ready'),
              _statusChip('Completed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String value) {
    final bool selected = status == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            status = value;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? AppTheme.coffeeDark : AppTheme.cream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : AppTheme.coffeeDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _statusBadge(String value) {
    Color color;

    if (value == 'Completed') {
      color = Colors.green;
    } else if (value == 'Ready') {
      color = Colors.orange;
    } else {
      color = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(value == 'Preparing' ? 0.15 : 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _updateStatus(String newStatus) {
    setState(() {
      status = newStatus;
      widget.order['status'] = newStatus;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Order marked as $newStatus')));
  }
}
