import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'staff_orders.dart';
import 'staff_inventory.dart';
import 'staff_profile.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    StaffDashboardHome(),
    StaffOrders(),
    StaffInventory(),
    StaffProfile(),
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
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Inventory',
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

class StaffDashboardHome extends StatelessWidget {
  const StaffDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'CAFFIORA',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeCard(),

            const SizedBox(height: 20),

            const Text(
              'Today Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    '28',
                    'Orders Assigned',
                    Icons.assignment_outlined,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    '22',
                    'Orders Completed',
                    Icons.check_circle_outline,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    '6',
                    'Orders Pending',
                    Icons.pending_actions_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Today's Task",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),

            const SizedBox(height: 8),

            _taskCard(
              Icons.local_cafe_outlined,
              'Prepare Cappuccino Mix',
              'Pending',
            ),

            const SizedBox(height: 10),

            _taskCard(
              Icons.inventory_2_outlined,
              'Restock Coffee Beans',
              'Pending',
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                    child: const Icon(Icons.schedule, color: AppTheme.coffee),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Shift',
                          style: TextStyle(fontSize: 12, color: AppTheme.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '08:00 - 16:00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coffeeDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.coffeeDark,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back, Marco',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Have a productive shift today!',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.coffee, size: 21),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 9, color: AppTheme.grey),
          ),
        ],
      ),
    );
  }

  Widget _taskCard(IconData icon, String title, String status) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        children: [
          Container(
            height: 43,
            width: 43,
            decoration: BoxDecoration(
              color: AppTheme.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.coffee),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
