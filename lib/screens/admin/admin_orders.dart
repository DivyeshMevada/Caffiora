import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  String selectedStatus = 'All';

  final List<Map<String, dynamic>> orders = [
    {
      'id': '#CF-134',
      'customer': 'Rajiv Kumar',
      'items': 'Velvet Espresso, Iced Matcha',
      'amount': 688,
      'status': 'Preparing',
      'time': '10:25 AM',
    },
    {
      'id': '#CF-133',
      'customer': 'Raj Patel',
      'items': 'Italian Roast, Iced Latte',
      'amount': 588,
      'status': 'Ready',
      'time': '10:12 AM',
    },
    {
      'id': '#CF-132',
      'customer': 'Aarav Shah',
      'items': 'Cold Brew',
      'amount': 309,
      'status': 'Completed',
      'time': '09:55 AM',
    },
    {
      'id': '#CF-131',
      'customer': 'Neha Mehta',
      'items': 'Caramel Macchiato',
      'amount': 319,
      'status': 'Preparing',
      'time': '09:42 AM',
    },
    {
      'id': '#CF-130',
      'customer': 'Jay Patel',
      'items': 'Iced Latte, Croissant',
      'amount': 488,
      'status': 'Completed',
      'time': '09:25 AM',
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusTabs(),

          Expanded(
            child: filteredOrders.isEmpty
                ? _emptyState()
                : ListView.builder(
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

  // ==========================================================
  // STATUS TABS
  // ==========================================================

  Widget _buildStatusTabs() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          final selected = selectedStatus == status;

          final count = status == 'All'
              ? orders.length
              : orders.where((order) => order['status'] == status).length;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedStatus = status;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 9),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppTheme.coffeeDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      color: selected ? Colors.white : AppTheme.coffeeDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withOpacity(0.2)
                          : AppTheme.cream,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        color: selected ? Colors.white : AppTheme.coffee,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // ORDER CARD
  // ==========================================================

  Widget _orderCard(Map<String, dynamic> order) {
    final String status = order['status'];

    Color statusColor;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        break;

      case 'Ready':
        statusColor = Colors.orange;
        break;

      case 'Preparing':
        statusColor = AppTheme.coffee;
        break;

      default:
        statusColor = AppTheme.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // --------------------------------------------------
          // TOP ROW
          // --------------------------------------------------
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
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
                        fontSize: 13,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Divider(color: Colors.grey.shade200, height: 1),

          const SizedBox(height: 13),

          // --------------------------------------------------
          // ITEMS
          // --------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.local_cafe_outlined,
                size: 18,
                color: AppTheme.coffee,
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Text(
                  order['items'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // --------------------------------------------------
          // AMOUNT / TIME
          // --------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: AppTheme.grey),
                  const SizedBox(width: 5),
                  Text(
                    order['time'],
                    style: const TextStyle(fontSize: 12, color: AppTheme.grey),
                  ),
                ],
              ),

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

          // --------------------------------------------------
          // ACTION BUTTON
          // --------------------------------------------------
          if (status != 'Completed')
            SizedBox(
              width: double.infinity,
              height: 43,
              child: OutlinedButton(
                onPressed: () {
                  _showOrderDetails(order);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.coffeeDark,
                  side: const BorderSide(color: AppTheme.coffeeLight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  status == 'Preparing'
                      ? 'View / Update Order'
                      : 'Mark as Completed',
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 43,
              child: OutlinedButton(
                onPressed: () {
                  _showOrderDetails(order);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.coffeeDark,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('View Order Details'),
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // ORDER DETAILS
  // ==========================================================

  void _showOrderDetails(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 25),
          decoration: const BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order ${order['id']}',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                    ),

                    _statusBadge(order['status']),
                  ],
                ),

                const SizedBox(height: 20),

                _detailRow(Icons.person_outline, 'Customer', order['customer']),

                _detailRow(Icons.access_time, 'Order Time', order['time']),

                _detailRow(Icons.local_cafe_outlined, 'Items', order['items']),

                _detailRow(
                  Icons.currency_rupee,
                  'Total',
                  '₹${order['amount']}',
                ),

                const SizedBox(height: 20),

                if (order['status'] == 'Preparing')
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _updateOrderStatus(order, 'Ready', sheetContext);
                          },
                          child: const Text('Mark as Ready'),
                        ),
                      ),
                    ],
                  )
                else if (order['status'] == 'Ready')
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _updateOrderStatus(
                              order,
                              'Completed',
                              sheetContext,
                            );
                          },
                          child: const Text('Mark as Completed'),
                        ),
                      ),
                    ],
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                      },
                      child: const Text('Close'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // UPDATE STATUS
  // ==========================================================

  void _updateOrderStatus(
    Map<String, dynamic> order,
    String newStatus,
    BuildContext sheetContext,
  ) {
    setState(() {
      order['status'] = newStatus;
    });

    Navigator.pop(sheetContext);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${order['id']} marked as $newStatus')),
    );
  }

  // ==========================================================
  // STATUS BADGE
  // ==========================================================

  Widget _statusBadge(String status) {
    Color color;

    if (status == 'Completed') {
      color = Colors.green;
    } else if (status == 'Ready') {
      color = Colors.orange;
    } else {
      color = AppTheme.coffee;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // DETAIL ROW
  // ==========================================================

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.coffee, size: 21),

          const SizedBox(width: 12),

          SizedBox(
            width: 85,
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: AppTheme.grey),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 45,
              color: AppTheme.coffeeLight,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No Orders Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'There are no $selectedStatus orders right now.',
            style: const TextStyle(color: AppTheme.grey),
          ),
        ],
      ),
    );
  }
}
