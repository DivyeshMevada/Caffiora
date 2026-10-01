import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class StaffProfile extends StatelessWidget {
  const StaffProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          children: [
            _profileHeader(),

            const SizedBox(height: 22),

            _shiftCard(),

            const SizedBox(height: 22),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ACCOUNT SETTINGS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            const SizedBox(height: 10),

            _settingsCard(context),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.shade200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'CAFFIORA Staff Panel',
              style: TextStyle(fontSize: 11, color: AppTheme.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.coffeeDark,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        children: [
          Container(
            height: 82,
            width: 82,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.coffeeLight, width: 3),
            ),
            child: const Icon(Icons.person, size: 44, color: AppTheme.coffee),
          ),

          const SizedBox(height: 14),

          const Text(
            'Marco Valente',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Senior Barista',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),

          const SizedBox(height: 17),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'STAFF MEMBER',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shiftCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
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
            child: const Icon(Icons.badge_outlined, color: AppTheme.coffee),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EMPLOYEE ID',
                  style: TextStyle(
                    fontSize: 9,
                    color: AppTheme.grey,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'CF - 002',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),
          ),

          Container(height: 40, width: 1, color: Colors.grey.shade200),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'SHIFT TIMING',
                style: TextStyle(
                  fontSize: 9,
                  color: AppTheme.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '08:00 - 16:00',
                style: TextStyle(
                  fontSize: 13,
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

  Widget _settingsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Column(
        children: [
          _settingItem(
            context,
            Icons.person_outline,
            'Personal Info',
            'Manage your personal information',
          ),
          _settingItem(
            context,
            Icons.notifications_none_outlined,
            'Notification Box',
            'Manage staff notifications',
          ),
          _settingItem(
            context,
            Icons.schedule_outlined,
            'Work Schedule',
            'View your work schedule',
          ),
          _settingItem(
            context,
            Icons.help_outline,
            'Help',
            'Get help and support',
          ),
        ],
      ),
    );
  }

  Widget _settingItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title selected')));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          children: [
            Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.coffee, size: 21),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: AppTheme.grey),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: AppTheme.grey),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully')),
                );
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
