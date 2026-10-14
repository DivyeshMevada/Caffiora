import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';
import '../customer/home_screen.dart';
import '../admin/admin_dashboard.dart';
import '../staff/staff_dashboard.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String selectedRole = 'Customer';

  bool obscurePassword = true;
  bool rememberMe = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // SHOW MESSAGE
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // LOGIN AND OPEN SELECTED ROLE DASHBOARD
  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // EMAIL VALIDATION
    if (email.isEmpty) {
      showMessage('Please enter your email');
      return;
    }

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email)) {
      showMessage('Enter a valid email address');
      return;
    }

    // PASSWORD VALIDATION
    if (password.isEmpty) {
      showMessage('Please enter your password');
      return;
    }

    if (password.length < 6) {
      showMessage(
        'Password must contain at least 6 characters',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final role = selectedRole.toLowerCase();

      // EXISTING DEMO LOGIN
      await AuthState.instance.login(
        userName: _getNameFromEmail(email),
        userEmail: email,
        userMobile: '',
        userRole: role,
      );

      if (!mounted) return;

      // OPEN SELECTED DASHBOARD
      Widget destination;

      if (role == 'admin') {
        destination = const AdminDashboard();
      } else if (role == 'staff') {
        destination = const StaffDashboard();
      } else {
        destination = const HomeScreen();
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => destination,
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      showMessage('Unable to login. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // CREATE DISPLAY NAME FROM EMAIL
  String _getNameFromEmail(String email) {
    final username = email.split('@').first.trim();

    if (username.isEmpty) {
      return selectedRole;
    }

    return username
        .replaceAll('.', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  // OPEN FORGOT PASSWORD PAGE
  void openForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ForgotPasswordScreen(),
      ),
    );
  }

  // OPEN REGISTRATION PAGE
  void openRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              // LOGO + COFFEE ICON
              Center(
                child: Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: AppTheme.coffeeDark,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.coffee,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // CAFFIORA TEXT
              const Center(
                child: Text(
                  'CAFFIORA',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // WELCOME TEXT
              const Center(
                child: Text(
                  'Welcome back! Sign in to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.grey,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // LOGIN ROLE BUTTONS
              const Text(
                'Login as',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    _roleButton('Customer'),
                    _roleButton('Staff'),
                    _roleButton('Admin'),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // EMAIL LABEL
              const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 9),

              // EMAIL TEXTFORMFIELD
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD LABEL
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 9),

              // PASSWORD TEXTFORMFIELD
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => loginUser(),
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
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // REMEMBER ME + FORGOT PASSWORD
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
                  const Expanded(
                    child: Text(
                      'Remember me',
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: openForgotPassword,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppTheme.coffeeDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isLoading ? null : loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.coffeeDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 23,
                          width: 23,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login as $selectedRole',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 18),

              const SizedBox(height: 10),

              // REGISTER TEXT + BUTTON
              if (selectedRole == 'Customer')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppTheme.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: openRegister,
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: AppTheme.coffeeDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ROLE SELECTOR BUTTON
  Widget _roleButton(String role) {
    final bool isSelected = selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = role;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.coffeeDark : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              role,
              style: TextStyle(
                color: isSelected ? Colors.white : AppTheme.coffeeDark,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
