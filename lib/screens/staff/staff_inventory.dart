import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class StaffInventory extends StatefulWidget {
  const StaffInventory({super.key});

  @override
  State<StaffInventory> createState() => _StaffInventoryState();
}

class _StaffInventoryState extends State<StaffInventory> {
  String selectedCategory = 'All Items';

  final List<String> categories = ['All Items', 'Consumables', 'Packing'];

  final List<Map<String, dynamic>> inventory = [
    {
      'name': 'Coffee Beans',
      'category': 'Consumables',
      'quantity': '12.5kg',
      'target': '20kg',
      'status': 'IN STOCK',
      'icon': Icons.coffee,
    },
    {
      'name': 'Milk',
      'category': 'Consumables',
      'quantity': '8 units',
      'target': '30 units',
      'status': 'REORDER SOON',
      'icon': Icons.local_drink,
    },
    {
      'name': 'Cups',
      'category': 'Packing',
      'quantity': '42 pcs',
      'target': '1000 pcs',
      'status': 'CRITICAL',
      'icon': Icons.local_cafe_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == 'All Items') {
      return inventory;
    }

    return inventory
        .where((item) => item['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Inventory',
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
          _categoryTabs(),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return _inventoryCard(filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryTabs() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 9),
              padding: const EdgeInsets.symmetric(horizontal: 17),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppTheme.coffeeDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: selected ? Colors.white : AppTheme.coffeeDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _inventoryCard(Map<String, dynamic> item) {
    final String status = item['status'];

    Color statusColor;

    switch (status) {
      case 'CRITICAL':
        statusColor = Colors.red;
        break;
      case 'REORDER SOON':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item['icon'], color: AppTheme.coffee, size: 25),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['category'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              const Text(
                'Current Stock',
                style: TextStyle(fontSize: 11, color: AppTheme.grey),
              ),
              const Spacer(),
              Text(
                item['quantity'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          _progressBar(item),

          const SizedBox(height: 8),

          Row(
            children: [
              const Text(
                'Target',
                style: TextStyle(fontSize: 10, color: AppTheme.grey),
              ),
              const Spacer(),
              Text(
                item['target'],
                style: const TextStyle(fontSize: 10, color: AppTheme.grey),
              ),
            ],
          ),

          if (status != 'IN STOCK') ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reorder request for ${item['name']}'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 17),
                label: const Text('Request Reorder'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _progressBar(Map<String, dynamic> item) {
    double progress;

    if (item['name'] == 'Coffee Beans') {
      progress = 12.5 / 20;
    } else if (item['name'] == 'Milk') {
      progress = 8 / 30;
    } else {
      progress = 42 / 1000;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: Colors.grey.shade200,
        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.coffee),
      ),
    );
  }
}
