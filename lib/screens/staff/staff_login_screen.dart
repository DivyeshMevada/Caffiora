import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'staff_dashboard.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const StaffDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 45),

              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: AppTheme.coffeeDark,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_cafe,
                  color: Colors.white,
                  size: 45,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'CAFFIORA',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Crafted With Distinction',
                style: TextStyle(
                  color: AppTheme.grey,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 55),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Staff Login',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome! Please sign in to access your staff dashboard.',
                  style: TextStyle(color: AppTheme.grey, fontSize: 14),
                ),
              ),

              const SizedBox(height: 28),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: AppTheme.coffee,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Remember me', style: TextStyle(fontSize: 13)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset option selected'),
                        ),
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'SECURE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 15),

              const Text(
                'Secure access for CAFFIORA Staff Member.',
                style: TextStyle(color: AppTheme.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
