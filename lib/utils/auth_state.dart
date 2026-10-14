import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  AuthState._();

  static final AuthState instance = AuthState._();

  final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

  String name = '';
  String email = '';
  String mobile = '';
  String role = 'customer';

  static const String loginKey = 'isLoggedIn';
  static const String nameKey = 'userName';
  static const String emailKey = 'userEmail';
  static const String mobileKey = 'userMobile';
  static const String roleKey = 'userRole';

  // LOGIN
  Future<void> login({
    required String userName,
    required String userEmail,
    required String userMobile,
    String userRole = 'customer',
  }) async {
    name = userName;
    email = userEmail;
    mobile = userMobile;
    role = userRole.toLowerCase();

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, true);
    await prefs.setString(nameKey, name);
    await prefs.setString(emailKey, email);
    await prefs.setString(mobileKey, mobile);
    await prefs.setString(roleKey, role);

    isLoggedIn.value = true;
  }

  // REGISTER CUSTOMER
  Future<void> register({
    required String userName,
    required String userEmail,
    required String userMobile,
    String userRole = 'customer',
  }) async {
    await login(
      userName: userName,
      userEmail: userEmail,
      userMobile: userMobile,
      userRole: userRole,
    );
  }

  // UPDATE PROFILE
  Future<void> updateProfile({
    required String userName,
    required String userEmail,
    required String userMobile,
  }) async {
    name = userName;
    email = userEmail;
    mobile = userMobile;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(nameKey, name);
    await prefs.setString(emailKey, email);
    await prefs.setString(mobileKey, mobile);

    isLoggedIn.value = true;
  }

  // RESTORE SESSION WHEN APP REOPENS
  Future<bool> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();

    final loggedIn = prefs.getBool(loginKey) ?? false;

    if (loggedIn) {
      name = prefs.getString(nameKey) ?? '';
      email = prefs.getString(emailKey) ?? '';
      mobile = prefs.getString(mobileKey) ?? '';
      role = prefs.getString(roleKey) ?? 'customer';

      isLoggedIn.value = true;
      return true;
    }

    name = '';
    email = '';
    mobile = '';
    role = 'customer';
    isLoggedIn.value = false;

    return false;
  }

  // CONTINUE AS GUEST
  Future<void> continueAsGuest() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, false);

    name = '';
    email = '';
    mobile = '';
    role = 'customer';

    isLoggedIn.value = false;
  }

  // LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(loginKey);
    await prefs.remove(nameKey);
    await prefs.remove(emailKey);
    await prefs.remove(mobileKey);
    await prefs.remove(roleKey);

    name = '';
    email = '';
    mobile = '';
    role = 'customer';

    isLoggedIn.value = false;
  }
}
