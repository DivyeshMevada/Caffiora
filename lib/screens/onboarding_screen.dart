import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'onboarding_page.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Discover the Art\nof coffee',
      'description':
          'Every cup is crafted with premium beans, rich aromas, and timeless elegance.',
      'icon': Icons.coffee,
    },
    {
      'title': 'From Bean To\nPerfect Brew',
      'description':
          'Experience handpicked beans, expert roasting, and rich flavors crafted for every coffee lover.',
      'icon': Icons.local_cafe,
    },
    {
      'title': 'Coffee, Your Way',
      'description':
          'Customize every cup exactly how you like it and order freshly brewed coffee in seconds.',
      'icon': Icons.coffee_maker,
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 20),
                child: TextButton(
                  onPressed: goToLogin,
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: AppTheme.coffeeDark, fontSize: 15),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return OnboardingPage(
                    title: page['title'],
                    description: page['description'],
                    icon: page['icon'],
                  );
                },
              ),
            ),

            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentPage == index ? 25 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppTheme.coffeeDark
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),

            const SizedBox(height: 25),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: nextPage,
                child: Text(
                  currentPage == pages.length - 1 ? 'Get Started' : 'Continue',
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
