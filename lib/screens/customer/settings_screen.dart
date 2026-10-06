import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool orderUpdates = true;
  bool offers = true;
  bool darkMode = false;

  String selectedLanguage = 'English';

  // =====================================================
  // LANGUAGE
  // =====================================================

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Select Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.coffeeDark,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption('English'),
              _languageOption('Hindi'),
              _languageOption('Gujarati'),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(String language) {
    return RadioListTile<String>(
      value: language,
      groupValue: selectedLanguage,
      activeColor: AppTheme.coffee,
      title: Text(language),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selectedLanguage = value;
        });

        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Language changed to $value',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  // =====================================================
  // CLEAR SETTINGS
  // =====================================================

  void _resetSettings() {
    setState(() {
      notifications = true;
      orderUpdates = true;
      offers = true;
      darkMode = false;
      selectedLanguage = 'English';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Settings restored to default',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =====================================================
  // ABOUT CAFFIORA
  // =====================================================

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'CAFFIORA',
      applicationVersion: '1.0.0',
      applicationLegalese: 'Brewed Fresh. Served with Elegance.',
      children: const [
        SizedBox(height: 15),
        Text(
          'CAFFIORA is a premium café experience '
          'designed for coffee lovers.',
        ),
      ],
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // =================================================
          // NOTIFICATIONS
          // =================================================

          _sectionTitle('Notifications'),

          _settingsCard(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                secondary: _iconBox(
                  Icons.notifications_outlined,
                ),
                title: const Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Receive app notifications',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                value: notifications,
                activeColor: AppTheme.coffee,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                secondary: _iconBox(
                  Icons.local_shipping_outlined,
                ),
                title: const Text(
                  'Order Updates',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Get updates about your orders',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                value: orderUpdates,
                activeColor: AppTheme.coffee,
                onChanged: notifications
                    ? (value) {
                        setState(() {
                          orderUpdates = value;
                        });
                      }
                    : null,
              ),
              const Divider(height: 1),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                secondary: _iconBox(
                  Icons.local_offer_outlined,
                ),
                title: const Text(
                  'Offers & Promotions',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Receive special offers and deals',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                value: offers,
                activeColor: AppTheme.coffee,
                onChanged: notifications
                    ? (value) {
                        setState(() {
                          offers = value;
                        });
                      }
                    : null,
              ),
            ],
          ),

          const SizedBox(height: 25),

          // =================================================
          // APPEARANCE
          // =================================================

          _sectionTitle('Appearance'),

          _settingsCard(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                secondary: _iconBox(
                  Icons.dark_mode_outlined,
                ),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Use dark appearance',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                value: darkMode,
                activeColor: AppTheme.coffee,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Theme preference updated',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 25),

          // =================================================
          // APP PREFERENCES
          // =================================================

          _sectionTitle('App Preferences'),

          _settingsCard(
            children: [
              ListTile(
                leading: _iconBox(
                  Icons.language_outlined,
                ),
                title: const Text(
                  'Language',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  selectedLanguage,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: _showLanguageDialog,
              ),
              const Divider(height: 1),
              ListTile(
                leading: _iconBox(
                  Icons.cleaning_services_outlined,
                ),
                title: const Text(
                  'Clear App Data',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Reset app preferences',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: _resetSettings,
              ),
            ],
          ),

          const SizedBox(height: 25),

          // =================================================
          // ABOUT
          // =================================================

          _sectionTitle('About'),

          _settingsCard(
            children: [
              ListTile(
                leading: _iconBox(
                  Icons.info_outline,
                ),
                title: const Text(
                  'About CAFFIORA',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'App information and version',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.grey,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: _showAbout,
              ),
              const Divider(height: 1),
              ListTile(
                leading: _iconBox(
                  Icons.privacy_tip_outlined,
                ),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Privacy Policy coming soon',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: _iconBox(
                  Icons.description_outlined,
                ),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Terms & Conditions coming soon',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // =================================================
          // FOOTER
          // =================================================

          const Center(
            child: Column(
              children: [
                Text(
                  'CAFFIORA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Brewed Fresh. Served with Elegance.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.grey,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // =====================================================
  // SECTION TITLE
  // =====================================================

  Widget _sectionTitle(String title) {
    return Padding(
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
    );
  }

  // =====================================================
  // SETTINGS CARD
  // =====================================================

  Widget _settingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // =====================================================
  // ICON BOX
  // =====================================================

  Widget _iconBox(IconData icon) {
    return Container(
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
    );
  }
}
