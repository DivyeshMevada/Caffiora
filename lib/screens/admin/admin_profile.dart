import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';
import '../auth/login_screen.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // APP BAR
      appBar: AppBar(
        backgroundColor: AppTheme.cream,
        elevation: 0,
        title: const Text(
          'Admin Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ),

      // SINGLE CHILD SCROLL VIEW
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        // MAIN COLUMN
        child: Column(
          children: [
            // PROFILE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppTheme.coffeeDark,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                children: [
                  // CIRCLE AVATAR
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,

                    // ADMIN ICON
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 48,
                      color: AppTheme.coffee,
                    ),
                  ),
                  SizedBox(height: 15),

                  // NAME TEXT
                  Text(
                    'OM ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),

                  // ROLE TEXT
                  Text(
                    'Administrator',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),

                  // ADMIN ACCOUNT BUTTON
                  Chip(
                    label: Text(
                      'ADMIN ACCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: AppTheme.coffee,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ACCOUNT INFORMATION HEADING
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'ACCOUNT INFORMATION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ACCOUNT INFORMATION CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  // NAME ROW
                  _infoRow(
                    Icons.person_outline,
                    'Name',
                    'OM ',
                  ),
                  const Divider(height: 25),

                  // ROLE ROW
                  _infoRow(
                    Icons.security_outlined,
                    'Role',
                    'Administrator',
                  ),
                  const Divider(height: 25),

                  // ORGANIZATION ROW
                  _infoRow(
                    Icons.store_outlined,
                    'Organization',
                    'CAFFIORA',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.red.shade200,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ADMIN PANEL FOOTER
            const Text(
              'CAFFIORA Admin Panel',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ACCOUNT INFORMATION ROW
  static Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppTheme.coffee,
          ),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // LOGOUT CONFIRMATION
  void _logout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        // ALERT DIALOG
        return AlertDialog(
          // TITLE
          title: const Text('Log Out'),

          // CONTENT TEXT
          content: const Text(
            'Are you sure you want to log out?',
          ),

          // DIALOG ACTIONS
          actions: [
            // CANCEL BUTTON
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),

            // LOG OUT BUTTON
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                await AuthState.instance.logout();

                if (!context.mounted) return;

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute<void>(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
