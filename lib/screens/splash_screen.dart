import 'package:caffiora/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/auth_state.dart';
import 'onboarding_screen.dart';
import 'customer/home_screen.dart';
import 'admin/admin_dashboard.dart';
import 'staff/staff_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final bool loggedIn = await AuthState.instance.restoreSession();

    if (!mounted) return;

    if (!loggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
      return;
    }

    final String role = AuthState.instance.role.toLowerCase();

    Widget destination;

    switch (role) {
      case 'admin':
        destination = const AdminDashboard();
        break;

      case 'staff':
        destination = const StaffDashboard();
        break;

      case 'customer':
      default:
        destination = const HomeScreen();
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => destination,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.coffeeDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 115,
              width: 115,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.coffee,
                size: 65,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'CAFFIORA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Brewed Fresh. Served with Elegance.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 35),
            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
