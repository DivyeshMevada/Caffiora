import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'home_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  bool scratched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,

      // MAIN COLUMN
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 45),

              // SUCCESS ICON
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppTheme.coffeeDark,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.coffee.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 55,
                ),
              ),

              const SizedBox(height: 30),

              // ORDER CONFIRMED
              const Text(
                'Order Confirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 48, 214, 92),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'THANK YOU',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeLight,
                ),
              ),

              const SizedBox(height: 16),

              // THANK YOU MESSAGE
              const Text(
                'Thank you for choosing CAFFIORA.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Every cup is crafted with care, and we're "
                "delighted to serve you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppTheme.grey,
                ),
              ),

              const SizedBox(height: 35),

              // ORDER DETAILS CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_cafe_outlined,
                      color: AppTheme.coffee,
                      size: 35,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Your coffee is being prepared',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.coffeeDark,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // DELIVERY TIME
                    const Text(
                      'Estimated delivery time: 20 - 25 mins',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.grey,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),

                    const SizedBox(height: 18),

                    // ORDER ID
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID',
                          style: TextStyle(
                            color: AppTheme.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '#CF-134',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.coffeeDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // CONTINUE SHOPPING BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // VIEW ORDER DETAILS
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'View Order Details',
                  style: TextStyle(
                    color: AppTheme.coffee,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
