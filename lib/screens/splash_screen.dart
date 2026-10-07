import 'package:caffiora/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/auth_state.dart';
import '../utils/cart_state.dart';
import 'customer/home_screen.dart';
// import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkApp();
  }

  // ==========================================================
  // CHECK APP SESSION + RESTORE CART
  // ==========================================================

  Future<void> checkApp() async {
    // Small splash delay
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    // ========================================================
    // RESTORE LOGIN SESSION
    // ========================================================

    final bool loggedIn = await AuthState.instance.restoreSession();

    // ========================================================
    // RESTORE CART
    // ========================================================

    await CartState.instance.restoreCart();

    // ========================================================
    // CHECK SCREEN
    // ========================================================

    if (!mounted) {
      return;
    }

    if (loggedIn) {
      // User already logged in
      // Open Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      // User not logged in
      // Open Onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  // ==========================================================
  // UI
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.coffeeDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ==================================================
            // LOGO
            // ==================================================

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

            const SizedBox(
              height: 25,
            ),

            // ==================================================
            // APP NAME
            // ==================================================

            const Text(
              'CAFFIORA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            // ==================================================
            // TAGLINE
            // ==================================================

            const Text(
              'Brewed Fresh. Served with Elegance.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),

            const SizedBox(
              height: 35,
            ),

            // ==================================================
            // LOADING
            // ==================================================

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
