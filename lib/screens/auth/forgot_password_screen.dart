import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendResetCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResetPasswordScreen(
          email: emailController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                // ==================================================
                // ICON
                // ==================================================

                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.coffeeDark,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 18,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.lock_reset,
                      size: 52,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // TITLE
                // ==================================================

                const Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    'No worries! Enter your registered email\n'
                    'address and we will help you reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.grey,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // EMAIL LABEL
                // ==================================================

                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),

                const SizedBox(height: 8),

                // ==================================================
                // EMAIL FIELD
                // ==================================================

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Enter your registered email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppTheme.coffee,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    );

                    if (!emailRegex.hasMatch(
                      value.trim(),
                    )) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                  onFieldSubmitted: (_) {
                    sendResetCode();
                  },
                ),

                const SizedBox(height: 25),

                // ==================================================
                // SEND BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : sendResetCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.coffeeDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 23,
                            width: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send_outlined,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // BACK TO LOGIN
                // ==================================================

                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 18,
                    ),
                    label: const Text(
                      'Back to Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.coffeeDark,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // BRAND
                // ==================================================

                const Center(
                  child: Text(
                    'CAFFIORA',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: AppTheme.coffeeDark,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                const Center(
                  child: Text(
                    'Brewed Fresh. Served with Elegance.',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
