import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Coffee Image Placeholder
          Container(
            height: 280,
            width: 280,
            decoration: BoxDecoration(
              color: AppTheme.coffeeDark,
              borderRadius: BorderRadius.circular(140),
            ),
            child: Icon(icon, size: 120, color: AppTheme.cream),
          ),

          const SizedBox(height: 45),

          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),

          const SizedBox(height: 20),

          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.6),
          ),
        ],
      ),
    );
  }
}
