import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';

import 'register_screen.dart';
import 'forgot_password_screen.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    await AuthState.instance.login(
      userName: 'Raj Patel',
      userEmail: emailController.text.trim(),
      userMobile: '9798347684',
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  // ============================================================
  // CONTINUE AS GUEST
  // ============================================================

  Future<void> continueAsGuest() async {
    await AuthState.instance.continueAsGuest();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  // ============================================================
  // FORGOT PASSWORD
  // ============================================================

  void openForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),

                // ==================================================
                // LOGO
                // ==================================================

                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: AppTheme.coffeeDark,
                          borderRadius: BorderRadius.circular(
                            35,
                          ),
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

                // ==================================================
                // WELCOME
                // ==================================================

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
                  'Login in to continue your premium\n'
                  'coffee experience.',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // EMAIL
                // ==================================================

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
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
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

                // ==================================================
                // PASSWORD
                // ==================================================

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
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
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

                // ==================================================
                // REMEMBER ME + FORGOT PASSWORD
                // ==================================================

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
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.grey,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: openForgotPassword,
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

                // ==================================================
                // LOGIN BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
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
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // OR
                // ==================================================

                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(
                //         color: Colors.grey.shade300,
                //       ),
                //     ),
                //     const Padding(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 15,
                //       ),
                //       child: Text(
                //         'OR',
                //         style: TextStyle(
                //           color: AppTheme.grey,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Divider(
                //         color: Colors.grey.shade300,
                //       ),
                //     ),
                //   ],
                // ),

                // const SizedBox(height: 20),

                // ==================================================
                // GUEST
                // ==================================================

                // SizedBox(
                //   width: double.infinity,
                //   height: 52,
                //   child: OutlinedButton(
                //     onPressed: continueAsGuest,
                //     style: OutlinedButton.styleFrom(
                //       side: const BorderSide(
                //         color: AppTheme.coffeeDark,
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(
                //           14,
                //         ),
                //       ),
                //     ),
                //     child: const Text(
                //       'Continue as Guest',
                //       style: TextStyle(
                //         color: AppTheme.coffeeDark,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),

                // const SizedBox(height: 25),

                // ==================================================
                // REGISTER
                // ==================================================

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppTheme.grey,
                        ),
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
