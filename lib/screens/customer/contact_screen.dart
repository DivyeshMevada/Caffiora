import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Message sent'),
          content: const Text(
            'This is a demo form. No email is sent. Thank you for contacting CAFFIORA.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                nameController.clear();
                emailController.clear();
                subjectController.clear();
                messageController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: AppTheme.coffeeDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We would love to hear from you.',
                  style: TextStyle(color: AppTheme.grey),
                ),
                const SizedBox(height: 24),
                _infoCard(Icons.location_on_outlined, 'Address',
                    AppConstants.address),
                _infoCard(Icons.phone_outlined, 'Phone', AppConstants.phone),
                _infoCard(Icons.email_outlined, 'Email', AppConstants.email),
                _infoCard(
                    Icons.access_time, 'Business hours', AppConstants.hours),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: nameController,
                  label: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
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
                const SizedBox(height: 16),
                CustomTextField(
                  controller: subjectController,
                  label: 'Subject',
                  hintText: 'How can we help?',
                  prefixIcon: Icons.subject,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: messageController,
                  label: 'Message',
                  hintText: 'Write your message',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(label: 'Send Message', onPressed: sendMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.coffee),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: AppTheme.grey, fontSize: 12)),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.coffeeDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
