import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#CF-134',
      'date': '06 Oct 2026',
      'time': '10:30 AM',
      'status': 'Delivered',
      'total': 688.0,
      'items': [
        {
          'name': 'Velvet Espresso',
          'quantity': 1,
          'price': 349.0,
        },
        {
          'name': 'Iced Matcha',
          'quantity': 1,
          'price': 279.0,
        },
      ],
    },
    // {
    //   'id': '#CF-128',
    //   'date': '03 Oct 2026',
    //   'time': '04:15 PM',
    //   'status': 'Preparing',
    //   'total': 588.0,
    //   'items': [
    //     {
    //       'name': 'Italian Roast',
    //       'quantity': 1,
    //       'price': 249.0,
    //     },
    //     {
    //       'name': 'Iced Latte',
    //       'quantity': 1,
    //       'price': 249.0,
    //     },
    //   ],
    // },
    // {
    //   'id': '#CF-121',
    //   'date': '29 Sep 2026',
    //   'time': '09:45 AM',
    //   'status': 'Delivered',
    //   'total': 588.0,
    //   'items': [
    //     {
    //       'name': 'Italian Roast',
    //       'quantity': 1,
    //       'price': 249.0,
    //     },
    //     {
    //       'name': 'Caramel Macchiato',
    //       'quantity': 1,
    //       'price': 319.0,
    //     },
    //   ],
    // },
    // {
    //   'id': '#CF-115',
    //   'date': '24 Sep 2026',
    //   'time': '06:20 PM',
    //   'status': 'Cancelled',
    //   'total': 279.0,
    //   'items': [
    //     {
    //       'name': 'Velvet Espresso',
    //       'quantity': 1,
    //       'price': 279.0,
    //     },
    //   ],
    // },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedFilter == 'All') {
      return orders;
    }

    return orders
        .where(
          (order) => order['status'] == selectedFilter,
        )
        .toList();
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;

      case 'Preparing':
        return Colors.orange;

      case 'Cancelled':
        return Colors.red;

      default:
        return AppTheme.coffee;
    }
  }

  IconData statusIcon(String status) {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle_outline;

      case 'Preparing':
        return Icons.access_time;

      case 'Cancelled':
        return Icons.cancel_outlined;

      default:
        return Icons.receipt_long;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // =========================
          // FILTER TABS
          // =========================
          SizedBox(
            height: 62,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              children: [
                _filterButton('All'),
                _filterButton('Preparing'),
                _filterButton('Delivered'),
                _filterButton('Cancelled'),
              ],
            ),
          ),

          const Divider(height: 1),

          // =========================
          // ORDERS
          // =========================
          Expanded(
            child: filteredOrders.isEmpty
                ? _emptyOrders()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];

                      return _orderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterButton(String title) {
    final isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.coffeeDark : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppTheme.coffeeDark : Colors.grey.shade300,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.coffeeDark,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order) {
    final status = order['status'] as String;
    final items = order['items'] as List;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // ORDER HEADER
            // =========================
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.cream,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['id'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order['date']} • ${order['time']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor(status).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon(status),
                        size: 15,
                        color: statusColor(status),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor(status),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Divider(),

            const SizedBox(height: 8),

            // =========================
            // ITEMS
            // =========================
            ...items.map(
              (item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color: AppTheme.cream,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.coffee,
                          size: 20,
                          color: AppTheme.coffee,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${item['name']} × ${item['quantity']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.coffeeDark,
                          ),
                        ),
                      ),
                      Text(
                        '₹${item['price'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 8),

            const Divider(),

            const SizedBox(height: 8),

            // =========================
            // TOTAL
            // =========================
            Row(
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${order['total'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // =========================
            // BUTTONS
            // =========================
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showOrderDetails(order);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 44),
                      side: const BorderSide(
                        color: AppTheme.coffeeDark,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: AppTheme.coffeeDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (status == 'Delivered')
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showMessage(
                          'Items added to cart',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: const Text(
                        'Reorder',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyOrders() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 45,
                color: AppTheme.coffee,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Orders Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You do not have any orders in this category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    final items = order['items'] as List;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  order['id'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${order['date']} • ${order['time']}',
                  style: const TextStyle(
                    color: AppTheme.grey,
                  ),
                ),
                const SizedBox(height: 20),
                ...items.map(
                  (item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${item['name']} × ${item['quantity']}',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            '₹${item['price'].toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '₹${order['total'].toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Close',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
