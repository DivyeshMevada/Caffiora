// import 'package:caffiora/screens/staff/staff_login_screen.dart';
// import 'package:caffiora/screens/customer/contact_screen.dart';
// import 'package:caffiora/screens/auth/register_screen.dart';
import 'package:caffiora/screens/splash_screen.dart';
// import 'package:caffiora/widgets/app_header.dart';
import 'package:flutter/material.dart';

// import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CaffioraApp());
}

class CaffioraApp extends StatelessWidget {
  const CaffioraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAFFIORA',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
