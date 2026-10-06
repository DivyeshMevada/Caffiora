import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, size: 15, color: Colors.amber),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 12, color: AppTheme.grey),
        ),
      ],
    );
  }
}
