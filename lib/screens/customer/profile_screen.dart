import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
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

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Raj Patel',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coffeeDark,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'rajpatel@gmail.com',
                          style: TextStyle(color: AppTheme.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '9798347684',
                          style: TextStyle(color: AppTheme.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Rewards
            Row(
              children: [
                Expanded(child: _statCard('1,248', 'Brew Points', Icons.stars)),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard('16', 'Total Orders', Icons.receipt_long),
                ),
                const SizedBox(width: 12),
                Expanded(child: _statCard('6', 'Favorites', Icons.favorite)),
              ],
            ),

            const SizedBox(height: 20),

            // Membership
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.coffeeDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gold Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You are a Gold Member',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '252 points away from platinum',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

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

            _profileOption(
              context,
              Icons.credit_card_outlined,
              'Payment Methods',
              'Manage your cards and wallets',
            ),

            _profileOption(
              context,
              Icons.favorite_border,
              'Wishlist',
              'Your favorite coffees and items',
            ),

            _profileOption(
              context,
              Icons.card_giftcard_outlined,
              'Brew Rewards',
              'View points, rewards and offers',
            ),

            _profileOption(
              context,
              Icons.local_offer_outlined,
              'Coupons & Offers',
              'View your coupons and exclusive offers',
            ),

            _profileOption(
              context,
              Icons.help_outline,
              'Help & Support',
              'Get help and support',
            ),

            _profileOption(
              context,
              Icons.settings_outlined,
              'Settings',
              'Manage your app preferences',
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppTheme.coffeeDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.coffee, size: 25),
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
            style: const TextStyle(fontSize: 10, color: AppTheme.grey),
          ),
        ],
      ),
    );
  }

  Widget _profileOption(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: AppTheme.cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.coffee),
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
          style: const TextStyle(fontSize: 11, color: AppTheme.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () {},
      ),
    );
  }
}
