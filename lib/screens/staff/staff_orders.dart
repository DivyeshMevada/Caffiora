import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'staff_order_details.dart';

class StaffOrders extends StatefulWidget {
  const StaffOrders({super.key});

  @override
  State<StaffOrders> createState() => _StaffOrdersState();
}

class _StaffOrdersState extends State<StaffOrders> {
  String selectedStatus = 'All';

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#CF-134',
      'customer': 'RAJIV KUMAR',
      'items': '2 Items (Espresso, Iced Matcha)',
      'amount': 688,
      'time': '4 min ago',
      'status': 'Preparing',
    },
    {
      'id': '#CF-133',
      'customer': 'KARAN PATEL',
      'items': '4 Items (Italian Roast, Croissant...)',
      'amount': 1279,
      'time': '26 min ago',
      'status': 'Completed',
    },
    {
      'id': '#CF-132',
      'customer': 'NEHA MEHTA',
      'items': '2 Items (Cold Brew, Latte)',
      'amount': 608,
      'time': '32 min ago',
      'status': 'Ready',
    },
    {
      'id': '#CF-131',
      'customer': 'JAY PATEL',
      'items': '1 Item (Caramel Macchiato)',
      'amount': 319,
      'time': '41 min ago',
      'status': 'Completed',
    },
  ];

  final List<String> statuses = ['All', 'Preparing', 'Ready', 'Completed'];

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedStatus == 'All') {
      return orders;
    }

    return orders.where((order) => order['status'] == selectedStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return _orderCard(filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          final selected = selectedStatus == status;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedStatus = status;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppTheme.coffeeDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: selected ? Colors.white : AppTheme.coffeeDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order) {
    final bool completed = order['status'] == 'Completed';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 47,
                width: 47,
                decoration: BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: AppTheme.coffee,
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
                      order['customer'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),
              _statusBadge(order['status']),
            ],
          ),

          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade200),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.local_cafe_outlined,
                size: 18,
                color: AppTheme.coffee,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  order['items'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(Icons.access_time, size: 15, color: AppTheme.grey),
              const SizedBox(width: 5),
              Text(
                order['time'],
                style: const TextStyle(fontSize: 11, color: AppTheme.grey),
              ),
              const Spacer(),
              Text(
                '₹${order['amount']}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 43,
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StaffOrderDetails(order: order),
                  ),
                );

                if (result != null) {
                  setState(() {});
                }
              },
              child: Text(
                completed
                    ? 'View Order History'
                    : 'View Details / Update Status',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;

    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'Ready':
        color = Colors.orange;
        break;
      default:
        color = AppTheme.coffee;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
