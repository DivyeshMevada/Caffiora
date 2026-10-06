import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/auth_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final auth = AuthState.instance;

    nameController = TextEditingController(text: auth.name);

    emailController = TextEditingController(text: auth.email);

    mobileController = TextEditingController(text: auth.mobile);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();

    super.dispose();
  }

  // ==========================================================
  // SAVE PROFILE
  // ==========================================================

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    await AuthState.instance.updateProfile(
      userName: nameController.text.trim(),
      userEmail: emailController.text.trim(),
      userMobile: mobileController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile updated successfully!',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context, true);
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // PROFILE ICON
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
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  'Update your profile',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.grey,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // NAME
              // ==================================================

              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppTheme.coffee,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }

                  if (value.trim().length < 2) {
                    return 'Name must contain at least 2 characters';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ==================================================
              // EMAIL
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

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
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

                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ==================================================
              // MOBILE
              // ==================================================

              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.coffeeDark,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter mobile number',
                  counterText: '',
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: AppTheme.coffee,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your mobile number';
                  }

                  if (!RegExp(
                    r'^[0-9]{10}$',
                  ).hasMatch(
                    value.trim(),
                  )) {
                    return 'Mobile number must be 10 digits';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // ==================================================
              // SAVE BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isSaving ? null : saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.coffeeDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isSaving
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
                              Icons.save_outlined,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Save Changes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // CANCEL
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.coffeeDark,
                    side: const BorderSide(
                      color: AppTheme.coffeeDark,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // FOOTER
              // ==================================================

              const Center(
                child: Text(
                  'CAFFIORA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              const Center(
                child: Text(
                  'Brewed Fresh. Served with Elegance.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.grey,
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
