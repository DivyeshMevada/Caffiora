import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';

import '../auth/login_screen.dart';
import 'contact_screen.dart';
import 'edit_profile_screen.dart';
import 'my_orders_screen.dart';
import 'saved_addresses_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ==========================================================
  // OPEN EDIT PROFILE
  // ==========================================================

  Future<void> openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditProfileScreen(),
      ),
    );

    if (result == true && mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthState.instance;

    final String userName = auth.name.isEmpty ? 'Divyesh' : auth.name;

    final String userEmail =
        auth.email.isEmpty ? 'divyesh@gmail.com' : auth.email;

    final String userMobile = auth.mobile.isEmpty ? '8320226902' : auth.mobile;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // ==================================================
          // EDIT BUTTON
          // ==================================================

          IconButton(
            onPressed: openEditProfile,
            icon: const Icon(
              Icons.edit_outlined,
            ),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ==================================================
            // PROFILE CARD
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // PROFILE IMAGE / ICON

                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: AppTheme.coffeeDark,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 15),

                  // USER INFORMATION

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coffeeDark,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          userEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userMobile,
                          style: const TextStyle(
                            color: AppTheme.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // STATS
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    value: '16',
                    title: 'Total Orders',
                    icon: Icons.receipt_long,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==================================================
            // ACCOUNT
            // ==================================================

            _sectionTitle('Account'),

            _profileOption(
              context,
              Icons.receipt_long_outlined,
              'My Orders',
              'View your past and upcoming orders',
            ),

            _profileOption(
              context,
              Icons.location_on_outlined,
              'Saved Addresses',
              'Manage your delivery addresses',
            ),

            const SizedBox(height: 15),

            // ==================================================
            // SUPPORT
            // ==================================================

            _sectionTitle('Support'),

            _profileOption(
              context,
              Icons.contact_support_outlined,
              'Contact Us',
              'Get in touch with CAFFIORA',
            ),

            const SizedBox(height: 15),

            // ==================================================
            // PREFERENCES
            // ==================================================

            _sectionTitle('Preferences'),

            _profileOption(
              context,
              Icons.settings_outlined,
              'Settings',
              'Manage your app preferences',
            ),

            const SizedBox(height: 15),

            // ==================================================
            // LOGOUT
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: AppTheme.coffeeDark,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppTheme.coffeeDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppTheme.coffeeDark,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // FOOTER
            // ==================================================

            const Text(
              'CAFFIORA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppTheme.coffeeDark,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Brewed Fresh. Served with Elegance.',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.grey,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Premium Coffee Experience',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.grey,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 4,
          bottom: 10,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.coffeeDark,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _statCard({
    required String value,
    required String title,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.coffee,
            size: 25,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE OPTION
  // ============================================================

  Widget _profileOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),
        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppTheme.coffee,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.coffeeDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.grey,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: AppTheme.grey,
        ),
        onTap: () {
          if (title == 'My Orders') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MyOrdersScreen(),
              ),
            );
          } else if (title == 'Saved Addresses') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SavedAddressesScreen(),
              ),
            );
          } else if (title == 'Contact Us') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ContactScreen(),
              ),
            );
          } else if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingsScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  // ============================================================
  // LOGOUT DIALOG
  // ============================================================

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.logout,
                color: AppTheme.coffeeDark,
              ),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout from CAFFIORA?',
          ),
          actions: [
            // CANCEL

            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.grey,
                ),
              ),
            ),

            // LOGOUT

            ElevatedButton(
              onPressed: () async {
                await AuthState.instance.logout();

                if (!context.mounted) {
                  return;
                }

                Navigator.pop(
                  dialogContext,
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.coffeeDark,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
