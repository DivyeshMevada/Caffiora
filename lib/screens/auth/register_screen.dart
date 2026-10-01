import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void sendOTP() {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Name validation
    if (name.isEmpty) {
      showMessage("Please enter your full name");
      return;
    }

    // Mobile validation
    if (mobile.isEmpty) {
      showMessage("Please enter mobile number");
      return;
    }

    if (mobile.length != 10) {
      showMessage("Enter valid 10-digit mobile number");
      return;
    }

    // Email validation
    if (email.isEmpty) {
      showMessage("Please enter email address");
      return;
    }

    if (!email.contains("@")) {
      showMessage("Please enter valid email address");
      return;
    }

    // Password validation
    if (password.isEmpty) {
      showMessage("Please enter password");
      return;
    }

    if (password.length < 6) {
      showMessage("Password must contain at least 6 characters");
      return;
    }

    // Confirm password
    if (confirmPassword.isEmpty) {
      showMessage("Please confirm your password");
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match");
      return;
    }

    // Terms
    if (!agreeTerms) {
      showMessage("Please accept Terms & Conditions");
      return;
    }

    // Open OTP screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPScreen(
          name: name,
          mobile: mobile,
          email: email,
          password: password,

          // Every normal registration = USER
          role: "user",
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Your Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Create your CAFFIORA account using mobile OTP verification.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              // NAME
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // MOBILE
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  hintText: "Enter 10-digit mobile number",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                  prefixText: "+91 ",
                  counterText: "",
                ),
              ),

              const SizedBox(height: 15),

              // EMAIL
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "example@gmail.com",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
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

              const SizedBox(height: 15),

              // CONFIRM PASSWORD
              TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  hintText: "Re-enter password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
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

              const SizedBox(height: 15),

              // TERMS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                      ),
                      child: Text(
                        "I agree to the Terms & Conditions and Privacy Policy",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // SEND OTP
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: sendOTP,
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // LOGIN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
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
}
