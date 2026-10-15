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

    // Scaffold
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // AppBar
      appBar: AppBar(
        // Reports & Analytics Title
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

      // SingleChildScrollView
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        // Main Column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selection Tabs
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),

              // Period Selection Row
              child: Row(
                children: ['Today', 'Weekly', 'Monthly'].map((period) {
                  final isSelected = selectedPeriod == period;

                  // Period Tab
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

                        // Period Text
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

            // Revenue Summary Card
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

              // Revenue Summary Column
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Revenue Heading
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

                  // Revenue Amount
                  Text(
                    data['revenue'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Revenue Growth Row
                  Row(
                    children: [
                      // Trending Icon
                      const Icon(
                        Icons.trending_up,
                        color: Colors.greenAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 6),

                      // Growth Text
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

            // Revenue Statistics Cards
            Row(
              children: [
                // Orders Statistics Card
                Expanded(
                  child: _statCard(
                    title: 'Orders',
                    value: data['orders'],
                    icon: Icons.shopping_bag_outlined,
                  ),
                ),
                const SizedBox(width: 12),

                // Average Order Statistics Card
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

            // Business Summary Heading
            const Text(
              'Business Summary',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            // Business Summary Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              // Business Summary Column
              child: Column(
                children: [
                  // Total Revenue Row
                  _summaryRow(
                    'Total Revenue',
                    data['revenue'],
                    Icons.currency_rupee,
                  ),
                  const Divider(height: 24),

                  // Total Orders Row
                  _summaryRow(
                    'Total Orders',
                    data['orders'],
                    Icons.receipt_long,
                  ),
                  const Divider(height: 24),

                  // Average Order Value Row
                  _summaryRow(
                    'Average Order Value',
                    data['average'],
                    Icons.analytics_outlined,
                  ),
                  const Divider(height: 24),

                  // Growth Row
                  _summaryRow(
                    'Growth',
                    data['growth'],
                    Icons.trending_up,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Top Products Heading
            const Text(
              'Top Products',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 6),

            // Top Products Description
            const Text(
              'Best-selling products by sales and revenue',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.grey,
              ),
            ),

            const SizedBox(height: 14),

            // Top Products List
            _buildTopProducts(),

            const SizedBox(height: 24),

            // Report Details Heading
            const Text(
              'Report Details',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            // Report Details Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),

              // Report Details Column
              child: Column(
                children: [
                  // Selected Period Row
                  _summaryRow(
                    'Selected Period',
                    selectedPeriod,
                    Icons.calendar_month,
                  ),
                  const Divider(height: 24),

                  // Products Tracked Row
                  _summaryRow(
                    'Products Tracked',
                    '${topProducts.length}',
                    Icons.inventory_2_outlined,
                  ),
                  const Divider(height: 24),

                  // Report Status Row
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

  // ==========================================================
  // STATISTICS CARD
  // ==========================================================
  // Container
  //  └── Column
  //       ├── Statistics Icon
  //       ├── Value Text
  //       └── Title Text

  // Small statistic card
  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    // Statistics Card Container
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      // Statistics Card Column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Icon
          Icon(
            icon,
            color: AppTheme.coffee,
            size: 24,
          ),
          const SizedBox(height: 12),

          // Value Text
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 4),

          // Title Text
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

  // ==========================================================
  // BUSINESS SUMMARY ROW
  // ==========================================================
  // Row
  //  ├── Icon Container
  //  │    └── Icon
  //  ├── Title Text
  //  └── Value Text

  // Business summary row
  Widget _summaryRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        // Icon Container
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.circular(12),
          ),

          // Summary Icon
          child: Icon(
            icon,
            color: AppTheme.coffee,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),

        // Title Text
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.grey,
            ),
          ),
        ),

        // Value Text
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

  // ==========================================================
  // TOP PRODUCTS LIST
  // ==========================================================
  // Container
  //  └── Column
  //       └── Product Row
  //            ├── Product Image
  //            ├── Product Name and Sales
  //            └── Product Revenue

  // Product list with image, sales and revenue
  Widget _buildTopProducts() {
    // Top Products Container
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      // Products Column
      child: Column(
        children: List.generate(topProducts.length, (index) {
          final product = topProducts[index];

          // Product Row
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == topProducts.length - 1 ? 0 : 16,
            ),
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product['image'],
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,

                    // Fallback Product Icon if Image Fails
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

                // Product Name and Sales
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Sales Count
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

                // Product Revenue
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Revenue Amount
                    Text(
                      '₹${product['revenue']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Revenue Label
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
