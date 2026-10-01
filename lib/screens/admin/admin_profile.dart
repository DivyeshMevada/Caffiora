import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: const Text(
          'Admin Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          children: [
            _buildProfileHeader(),

            const SizedBox(height: 22),

            _buildSection(
              title: 'Cafe Management',
              children: [
                _profileOption(
                  context,
                  icon: Icons.storefront_outlined,
                  title: 'Cafe Information',
                  subtitle: 'Manage cafe details',
                  onTap: () {
                    _showMessage(context, 'Cafe Information selected');
                  },
                ),
                _profileOption(
                  context,
                  icon: Icons.notifications_none_outlined,
                  title: 'Notification',
                  subtitle: 'Manage admin notifications',
                  onTap: () {
                    _showNotificationSettings(context);
                  },
                ),
                _profileOption(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  subtitle: 'Customize app appearance',
                  onTap: () {
                    _showMessage(context, 'Appearance selected');
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),

            _buildSection(
              title: 'Security & Data',
              children: [
                _profileOption(
                  context,
                  icon: Icons.lock_outline,
                  title: 'Security',
                  subtitle: 'Password and account security',
                  onTap: () {
                    _showMessage(context, 'Security selected');
                  },
                ),
                _profileOption(
                  context,
                  icon: Icons.backup_outlined,
                  title: 'Backup & Data',
                  subtitle: 'Manage backup and application data',
                  onTap: () {
                    _showBackupDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),

            _buildSection(
              title: 'Support',
              children: [
                _profileOption(
                  context,
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help and contact support',
                  onTap: () {
                    _showMessage(context, 'Help & Support selected');
                  },
                ),
                _profileOption(
                  context,
                  icon: Icons.info_outline,
                  title: 'About App',
                  subtitle: 'CAFFIORA Admin Panel',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildLogoutButton(context),

            const SizedBox(height: 15),

            const Text(
              'CAFFIORA Admin Panel',
              style: TextStyle(fontSize: 12, color: AppTheme.grey),
            ),

            const SizedBox(height: 4),

            const Text(
              'Premium Café Management',
              style: TextStyle(fontSize: 11, color: AppTheme.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
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
            child: const Icon(Icons.person, size: 45, color: AppTheme.coffee),
          ),

          const SizedBox(height: 14),

          const Text(
            'Om Sidpara',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'ADMINISTRATOR',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_outlined, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Admin Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 9),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _profileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(19),
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
                    style: const TextStyle(fontSize: 11, color: AppTheme.grey),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: AppTheme.grey, size: 21),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          _showLogoutDialog(context);
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text(
          'LOG OUT',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red.shade200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    bool notifications = true;
    bool orders = true;
    bool inventory = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                  const SizedBox(height: 18),

                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('All Notifications'),
                    value: notifications,
                    activeColor: AppTheme.coffee,
                    onChanged: (value) {
                      setModalState(() {
                        notifications = value;
                      });
                    },
                  ),

                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Order Notifications'),
                    value: orders,
                    activeColor: AppTheme.coffee,
                    onChanged: (value) {
                      setModalState(() {
                        orders = value;
                      });
                    },
                  ),

                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Inventory Alerts'),
                    value: inventory,
                    activeColor: AppTheme.coffee,
                    onChanged: (value) {
                      setModalState(() {
                        inventory = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Backup & Data'),
          content: const Text(
            'Manage CAFFIORA application backup '
            'and stored data from this section.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _showMessage(context, 'Backup started successfully');
              },
              child: const Text('Backup Now'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'CAFFIORA',
            style: TextStyle(
              color: AppTheme.coffeeDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Panel',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Premium Café Management Application',
                style: TextStyle(color: AppTheme.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Version 1.0.0',
                style: TextStyle(color: AppTheme.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout '
            'from the admin account?',
          ),
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

                _showMessage(context, 'Logged out successfully');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
