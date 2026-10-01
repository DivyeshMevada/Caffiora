import 'package:flutter/material.dart';

import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final mobileController = TextEditingController();

  void sendOTP() {
    final mobile = mobileController.text.trim();

    if (mobile.length != 10) {
      showMessage("Please enter a valid 10-digit mobile number");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(
          mobile: mobile,
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.lock_reset,
              size: 75,
              color: Color(0xFF6F4E37),
            ),
            const SizedBox(height: 25),
            const Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enter your registered mobile number. "
              "We will send you an OTP to reset your password.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                prefixIcon: Icon(Icons.phone_outlined),
                prefixText: "+91 ",
                counterText: "",
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: sendOTP,
                child: const Text(
                  "Send OTP",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
