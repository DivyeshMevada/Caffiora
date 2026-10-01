import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
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
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: AppTheme.cream,
                borderRadius: BorderRadius.circular(55),
              ),
              child: const Icon(
                Icons.coffee,
                size: 55,
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
                letterSpacing: 5,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Crafted With Distinction',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
