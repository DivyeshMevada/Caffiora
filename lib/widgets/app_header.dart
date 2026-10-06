import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/constants.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onCartTap;

  const AppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppTheme.coffeeDark),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? AppConstants.appName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: AppTheme.coffeeDark,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 11, color: AppTheme.grey),
                ),
              ],
            ],
          ),
        ),
        if (onCartTap != null)
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onCartTap,
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: AppTheme.coffeeDark,
              ),
            ),
          ),
      ],
    );
  }
}
