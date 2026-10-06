import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double fontSize;

  const PriceWidget({
    super.key,
    required this.price,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '₹${price.toInt()}',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: AppTheme.coffeeDark,
      ),
    );
  }
}
