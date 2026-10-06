import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/auth_state.dart';
import 'customer/home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkLogin();
  }

  Future<void> _checkLogin() async {
    // Splash screen display time
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // Check previous login
    final bool loggedIn = await AuthState.instance.restoreSession();

    if (!mounted) return;

    if (loggedIn) {
      // Already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      // Not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.coffeeDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
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

            // App Name
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
