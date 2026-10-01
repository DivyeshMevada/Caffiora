import 'package:flutter/material.dart';
import '../customer/home_screen.dart';

class OTPScreen extends StatefulWidget {
  final String name;
  final String mobile;
  final String email;
  final String password;
  final String role;

  const OTPScreen({
    super.key,
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();

  void verifyOTP() {
    if (otpController.text == "123456") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.sms_outlined,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter OTP",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "OTP sent to +91 ${widget.mobile}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: "Enter 6 Digit OTP",
                hintText: "123456",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: verifyOTP,
                child: const Text(
                  "Verify OTP",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Demo OTP: 123456",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
