import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AdminReports extends StatefulWidget {
  const AdminReports({super.key});

  @override
  State<AdminReports> createState() => _AdminReportsState();
}

class _AdminReportsState extends State<AdminReports> {
  String selectedPeriod = 'Monthly';

  final List<Map<String, dynamic>> topProducts = [
    {
      'name': 'Italian Roast',
      'sales': 248,
      'revenue': 61752,
      'image': 'assets/images/italian_roast.jpg',
      'icon': Icons.coffee,
    },
    {
      'name': 'Caramel Macchiato',
      'sales': 196,
      'revenue': 62524,
      'image': 'assets/images/caramel_macchiato.jpg',
      'icon': Icons.local_cafe,
    },
    {
      'name': 'Velvet Espresso',
      'sales': 182,
      'revenue': 50778,
      'image': 'assets/images/velvet_espresso.jpg',
      'icon': Icons.coffee_outlined,
    },
    {
      'name': 'Iced Latte',
      'sales': 165,
      'revenue': 41085,
      'image': 'assets/images/iced_latte.jpg',
      'icon': Icons.emoji_food_beverage,
    },
    {
      'name': 'Cold Brew',
      'sales': 142,
      'revenue': 35358,
      'image': 'assets/images/cold_brew.jpg',
      'icon': Icons.local_drink,
    },
  ];

  // Report values for each selected period
  Map<String, dynamic> get reportData {
    switch (selectedPeriod) {
      case 'Today':
        return {
          'revenue': '₹12,450',
          'orders': '42',
          'average': '₹296',
          'growth': '+8.5%',
        };
      case 'Weekly':
        return {
          'revenue': '₹78,650',
          'orders': '286',
          'average': '₹275',
          'growth': '+12.4%',
        };
      default:
        return {
          'revenue': '₹2,45,680',
          'orders': '892',
          'average': '₹276',
          'growth': '+18.2%',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = reportData;

    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Reports & Analytics',
          style: TextStyle(
            color: AppTheme.coffeeDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.cream,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.coffeeDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: ['Today', 'Weekly', 'Monthly'].map((period) {
                  final isSelected = selectedPeriod == period;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = period;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppTheme.coffee : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          period,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : AppTheme.coffeeDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Revenue summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.coffeeDark,
                    AppTheme.coffee,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL REVENUE',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['revenue'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        color: Colors.greenAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${data['growth']} compared to previous period',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Revenue statistic cards
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: 'Orders',
                    value: data['orders'],
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: 'Avg. Order',
                    value: data['average'],
                    icon: Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Business summary heading
            const Text(
              'Business Summary',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _summaryRow(
                    'Total Revenue',
                    data['revenue'],
                    Icons.currency_rupee,
                  ),
                  const Divider(height: 24),
                  _summaryRow(
                    'Total Orders',
                    data['orders'],
                    Icons.receipt_long,
                  ),
                  const Divider(height: 24),
                  _summaryRow(
                    'Average Order Value',
                    data['average'],
                    Icons.analytics_outlined,
                  ),
                  const Divider(height: 24),
                  _summaryRow(
                    'Growth',
                    data['growth'],
                    Icons.trending_up,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Top products heading
            const Text(
              'Top Products',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Best-selling products by sales and revenue',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.grey,
              ),
            ),

            const SizedBox(height: 14),

            _buildTopProducts(),

            const SizedBox(height: 24),

            // Report details
            const Text(
              'Report Details',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _summaryRow(
                    'Selected Period',
                    selectedPeriod,
                    Icons.calendar_month,
                  ),
                  const Divider(height: 24),
                  _summaryRow(
                    'Products Tracked',
                    '${topProducts.length}',
                    Icons.inventory_2_outlined,
                  ),
                  const Divider(height: 24),
                  _summaryRow(
                    'Report Status',
                    'Available',
                    Icons.check_circle_outline,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Small statistic card
  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.coffee,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Business summary row
  Widget _summaryRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppTheme.coffee,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.grey,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ],
    );
  }

  // Product list with image, sales and revenue
  Widget _buildTopProducts() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: List.generate(topProducts.length, (index) {
          final product = topProducts[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == topProducts.length - 1 ? 0 : 16,
            ),
            child: Row(
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product['image'],
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppTheme.cream,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          product['icon'] as IconData,
                          color: AppTheme.coffee,
                          size: 28,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Product name and sales
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${product['sales']} items sold',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Product revenue
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${product['revenue']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Revenue',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
