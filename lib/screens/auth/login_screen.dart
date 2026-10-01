import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'register_screen.dart';
import '../customer/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

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

  void login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void continueAsGuest() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),

                // Logo
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppTheme.coffeeDark,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: const Icon(
                          Icons.coffee,
                          color: AppTheme.cream,
                          size: 35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'CAFFIORA',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                          color: AppTheme.coffeeDark,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Crafted With Distinction',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 2,
                          color: AppTheme.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 55),

                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Login in to continue your premium\ncoffee experience.',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                // Email
                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                // Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must contain at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                // Remember + Forgot Password
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      activeColor: AppTheme.coffeeDark,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(fontSize: 13, color: AppTheme.grey),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Forgot Password feature coming soon',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: AppTheme.coffeeDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // OR
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('OR', style: TextStyle(color: AppTheme.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 20),

                // Guest
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: continueAsGuest,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.coffeeDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continue as Guest',
                      style: TextStyle(
                        color: AppTheme.coffeeDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Register
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: AppTheme.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            color: AppTheme.coffeeDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
