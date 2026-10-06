import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept Terms & Conditions',
          ),
        ),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OTPScreen(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          mobile: mobileController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Center(
                child: Icon(
                  Icons.person_add_alt_1,
                  size: 65,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter name';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Email',
                style: TextStyle(
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
                    return 'Please enter email';
                  }

                  if (!value.contains('@')) {
                    return 'Enter valid email';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: 'Enter mobile number',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter mobile number';
                  }

                  if (value.length != 10) {
                    return 'Enter valid 10 digit number';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Create password',
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
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }

                  if (value.length < 6) {
                    return 'Minimum 6 characters';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Confirm Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Re-enter password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm password';
                  }

                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    activeColor: AppTheme.coffeeDark,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to Terms & Conditions and Privacy Policy',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: AppTheme.coffeeDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
