import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';
import '../customer/home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String name;
  final String email;
  final String mobile;

  const OTPScreen({
    super.key,
    required this.name,
    required this.email,
    required this.mobile,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

  Future<void> _verifyOTP() async {
    if (otpController.text.trim() != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid OTP. Use 123456',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    // Save registration/login
    await AuthState.instance.register(
      userName: widget.name,
      userEmail: widget.email,
      userMobile: widget.mobile,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // Go directly to Home
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: AppTheme.coffeeDark,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.verified_user_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Verify Your Account',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppTheme.coffeeDark,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'OTP sent to ${widget.mobile}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.grey,
              ),
            ),
            const SizedBox(height: 35),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
              decoration: const InputDecoration(
                hintText: '000000',
                counterText: '',
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: isLoading ? null : _verifyOTP,
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Verify & Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Demo OTP: 123456',
              style: TextStyle(
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
