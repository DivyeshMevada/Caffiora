import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AdminReports extends StatefulWidget {
  const AdminReports({super.key});

  @override
  State<AdminReports> createState() => _AdminReportsState();
}

class _AdminReportsState extends State<AdminReports> {
  String selectedPeriod = 'Monthly';

  final List<String> periods = ['Today', 'Weekly', 'Monthly'];

  final List<Map<String, dynamic>> topProducts = [
    {
      'name': 'Italian Roast',
      'sales': 248,
      'revenue': 61752,
      'icon': Icons.coffee,
    },
    {
      'name': 'Caramel Macchiato',
      'sales': 196,
      'revenue': 62524,
      'icon': Icons.local_cafe,
    },
    {
      'name': 'Velvet Espresso',
      'sales': 182,
      'revenue': 50778,
      'icon': Icons.coffee_outlined,
    },
    {
      'name': 'Iced Latte',
      'sales': 165,
      'revenue': 41085,
      'icon': Icons.emoji_food_beverage,
    },
    {
      'name': 'Cold Brew',
      'sales': 142,
      'revenue': 35358,
      'icon': Icons.local_drink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _showExportMessage,
            icon: const Icon(Icons.download_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),

            const SizedBox(height: 20),

            _buildRevenueHeader(),

            const SizedBox(height: 18),

            _buildRevenueCards(),

            const SizedBox(height: 22),

            _buildSectionTitle('Sales Overview', 'Revenue performance'),

            const SizedBox(height: 12),

            _buildSalesChart(),

            const SizedBox(height: 24),

            _buildSectionTitle(
              'Business Summary',
              'Key performance indicators',
            ),

            const SizedBox(height: 12),

            _buildBusinessSummary(),

            const SizedBox(height: 24),

            _buildSectionTitle('Top Products', 'Best selling products'),

            const SizedBox(height: 12),

            _buildTopProducts(),

            const SizedBox(height: 24),

            _buildSectionTitle('Report Details', 'Current period statistics'),

            const SizedBox(height: 12),

            _buildReportDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: periods.map((period) {
          final bool selected = selectedPeriod == period;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppTheme.coffeeDark : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: selected ? Colors.white : AppTheme.coffeeDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRevenueHeader() {
    String amount;

    if (selectedPeriod == 'Today') {
      amount = '₹24,550';
    } else if (selectedPeriod == 'Weekly') {
      amount = '₹98,850';
    } else {
      amount = '₹8,19,350';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.coffeeDark, AppTheme.coffee],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bar_chart_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Total Revenue',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '+13.6%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '$selectedPeriod revenue',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCards() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.today_outlined,
            title: 'Today',
            value: '₹24,550',
            change: '+12%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.date_range_outlined,
            title: 'Weekly',
            value: '₹98,850',
            change: '+9.8%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.calendar_month_outlined,
            title: 'Monthly',
            value: '₹398,850',
            change: '+13.6%',
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required String change,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppTheme.coffee),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(fontSize: 11, color: AppTheme.grey),
          ),

          const SizedBox(height: 4),

          FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            change,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: AppTheme.grey),
              ),
            ],
          ),
        ),
        const Icon(Icons.more_horiz, color: AppTheme.grey),
      ],
    );
  }

  Widget _buildSalesChart() {
    final List<double> values = [0.35, 0.55, 0.42, 0.72, 0.62, 0.86, 0.78];

    final List<String> labels = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    return Container(
      height: 235,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '₹398,850',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  '+13.6%',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(values.length, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: values[index],
                              child: Container(
                                width: 20,
                                decoration: BoxDecoration(
                                  color: AppTheme.coffeeLight,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(7),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          labels[index],
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessSummary() {
    return Column(
      children: [
        _summaryRow(
          Icons.receipt_long_outlined,
          'Total Orders',
          '1,248',
          '+11.2%',
        ),
        const SizedBox(height: 10),
        _summaryRow(Icons.people_outline, 'Customers', '423', '+8.5%'),
        const SizedBox(height: 10),
        _summaryRow(
          Icons.shopping_bag_outlined,
          'Average Order',
          '₹656',
          '+4.2%',
        ),
        const SizedBox(height: 10),
        _summaryRow(
          Icons.star_outline,
          'Average Rating',
          '4.8 / 5',
          'Excellent',
        ),
      ],
    );
  }

  Widget _summaryRow(IconData icon, String title, String value, String change) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.coffee, size: 21),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: AppTheme.grey),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                change,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: topProducts.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (context, index) {
          final product = topProducts[index];

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: AppTheme.cream,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(product['icon'], color: AppTheme.coffee),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${product['sales']} orders',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  '₹${product['revenue']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportDetails() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _reportRow('Total Revenue', '₹8,19,350'),
          _reportRow('Today Revenue', '₹24,550'),
          _reportRow('Weekly Revenue', '₹98,850'),
          _reportRow('Monthly Revenue', '₹398,850'),
          _reportRow('Total Orders', '1,248'),
          _reportRow('Total Customers', '423'),
          _reportRow('Active Users', '2,489', last: true),
        ],
      ),
    );
  }

  Widget _reportRow(String title, String value, {bool last = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: AppTheme.grey),
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
      ),
    );
  }

  void _showExportMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report export option selected.')),
    );
  }
}
