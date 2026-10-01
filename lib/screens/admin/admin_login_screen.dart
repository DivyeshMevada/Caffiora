import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Logo
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: AppTheme.coffeeDark,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_cafe_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),

                  const SizedBox(height: 20),

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
                      fontSize: 13,
                      color: AppTheme.coffeeLight,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 45),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Admin Login',
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
                      'Login to manage your CAFFIORA cafe.',
                      style: TextStyle(fontSize: 14, color: AppTheme.grey),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter admin email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter email address';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  // Remember me
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
                      const Text(
                        'Remember me',
                        style: TextStyle(color: AppTheme.grey),
                      ),
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

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // OR
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'OR',
                          style: TextStyle(color: AppTheme.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Back to customer app
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 52),
                      foregroundColor: AppTheme.coffeeDark,
                      side: const BorderSide(color: AppTheme.coffeeLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Back to Customer App'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
