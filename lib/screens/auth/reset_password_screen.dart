import 'package:flutter/material.dart';

import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String mobile;

  const ResetPasswordScreen({
    super.key,
    required this.mobile,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool otpVerified = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Demo OTP
  final String demoOTP = "123456";

  void verifyOTP() {
    if (otpController.text.trim() != demoOTP) {
      showMessage("Invalid OTP");
      return;
    }

    setState(() {
      otpVerified = true;
    });

    showMessage("OTP verified successfully");
  }

  void resetPassword() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (!otpVerified) {
      showMessage("Please verify OTP first");
      return;
    }

    if (password.length < 6) {
      showMessage(
        "Password must contain at least 6 characters",
      );
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match");
      return;
    }

    showMessage("Password reset successfully");

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Icon(
              Icons.lock_reset,
              size: 70,
              color: Color(0xFF6F4E37),
            ),
            const SizedBox(height: 20),
            const Text(
              "Reset Your Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "OTP sent to +91 ${widget.mobile}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            if (!otpVerified) ...[
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  letterSpacing: 6,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  prefixIcon: Icon(Icons.password),
                  counterText: "",
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
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  "Demo OTP: 123456",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
            if (otpVerified) ...[
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "New Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: resetPassword,
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
