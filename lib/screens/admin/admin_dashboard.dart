import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'admin_management.dart';
import 'admin_orders.dart';
import 'admin_reports.dart';
import 'admin_profile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardContent(),
    AdminManagement(),
    AdminOrders(),
    AdminReports(),
    AdminProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.cream,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Manage',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD CONTENT
// ============================================================

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CAFFIORA',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            Text(
              'Admin Dashboard',
              style: TextStyle(fontSize: 12, color: AppTheme.grey),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // WELCOME
            // --------------------------------------------------
            const Text(
              'Good Morning, Admin',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Here is today\'s cafe overview.',
              style: TextStyle(color: AppTheme.grey, fontSize: 14),
            ),

            const SizedBox(height: 22),

            // --------------------------------------------------
            // STATISTICS
            // --------------------------------------------------
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _statCard(
                  title: 'Sales',
                  value: '₹24,550',
                  change: '+12%',
                  icon: Icons.currency_rupee,
                ),
                _statCard(
                  title: 'Revenue',
                  value: '₹8.19L',
                  change: '+13.6%',
                  icon: Icons.trending_up,
                ),
                _statCard(
                  title: 'Today Orders',
                  value: '98',
                  change: '+8%',
                  icon: Icons.shopping_bag_outlined,
                ),
                _statCard(
                  title: 'Active Users',
                  value: '2,489',
                  change: '+5%',
                  icon: Icons.people_outline,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // QUICK ACTIONS
            // --------------------------------------------------
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _quickAction(
                    icon: Icons.add_box_outlined,
                    title: 'Add Product',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add Product selected')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _quickAction(
                    icon: Icons.receipt_long_outlined,
                    title: 'View Orders',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View Orders selected')),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // TOP PRODUCTS
            // --------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),

            const SizedBox(height: 10),

            _productCard(
              rank: '01',
              name: 'Velvet Espresso',
              sold: '248 sold',
              price: '₹279',
              icon: Icons.local_cafe_outlined,
            ),

            _productCard(
              rank: '02',
              name: 'Italian Roast',
              sold: '216 sold',
              price: '₹249',
              icon: Icons.coffee_outlined,
            ),

            _productCard(
              rank: '03',
              name: 'Caramel Macchiato',
              sold: '189 sold',
              price: '₹319',
              icon: Icons.local_drink_outlined,
            ),

            _productCard(
              rank: '04',
              name: 'Iced Latte',
              sold: '164 sold',
              price: '₹249',
              icon: Icons.icecream_outlined,
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // RECENT ORDERS
            // --------------------------------------------------
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 14),

            _orderCard(
              orderId: '#CF-134',
              customer: 'Rajiv Kumar',
              items: 'Velvet Espresso, Iced Matcha',
              amount: '₹688',
              status: 'Preparing',
            ),

            _orderCard(
              orderId: '#CF-133',
              customer: 'Raj Patel',
              items: 'Italian Roast, Iced Latte',
              amount: '₹588',
              status: 'Ready',
            ),

            _orderCard(
              orderId: '#CF-132',
              customer: 'Aarav Shah',
              items: 'Cold Brew',
              amount: '₹309',
              status: 'Completed',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STAT CARD
  // ==========================================================

  Widget _statCard({
    required String title,
    required String value,
    required String change,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: AppTheme.coffee),
              ),
              const Spacer(),
              Text(
                change,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppTheme.grey),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // QUICK ACTION
  // ==========================================================

  Widget _quickAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.coffee, size: 22),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PRODUCT CARD
  // ==========================================================

  Widget _productCard({
    required String rank,
    required String name,
    required String sold,
    required String price,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: AppTheme.coffee),
          ),

          const SizedBox(width: 12),

          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: AppTheme.coffeeDark,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sold,
                  style: const TextStyle(fontSize: 12, color: AppTheme.grey),
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
    );
  }

  // ==========================================================
  // ORDER CARD
  // ==========================================================

  Widget _orderCard({
    required String orderId,
    required String customer,
    required String items,
    required String amount,
    required String status,
  }) {
    Color statusColor;

    if (status == 'Completed') {
      statusColor = Colors.green;
    } else if (status == 'Ready') {
      statusColor = Colors.orange;
    } else {
      statusColor = AppTheme.coffee;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(12),
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
                  orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  customer,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  items,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AppTheme.grey),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
