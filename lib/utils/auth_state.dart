import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  AuthState._();

  static final AuthState instance = AuthState._();

  final ValueNotifier<bool> isLoggedIn = ValueNotifier<bool>(false);

  String name = '';
  String email = '';
  String mobile = '';

  static const String loginKey = 'isLoggedIn';
  static const String nameKey = 'userName';
  static const String emailKey = 'userEmail';
  static const String mobileKey = 'userMobile';

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login({
    required String userName,
    required String userEmail,
    required String userMobile,
  }) async {
    name = userName;
    email = userEmail;
    mobile = userMobile;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, true);
    await prefs.setString(nameKey, userName);
    await prefs.setString(emailKey, userEmail);
    await prefs.setString(mobileKey, userMobile);

    isLoggedIn.value = true;
  }

  // ==========================================================
  // REGISTER
  // ==========================================================

  Future<void> register({
    required String userName,
    required String userEmail,
    required String userMobile,
  }) async {
    name = userName;
    email = userEmail;
    mobile = userMobile;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, true);
    await prefs.setString(nameKey, userName);
    await prefs.setString(emailKey, userEmail);
    await prefs.setString(mobileKey, userMobile);

    isLoggedIn.value = true;
  }

  // ==========================================================
  // UPDATE PROFILE
  // ==========================================================

  Future<void> updateProfile({
    required String userName,
    required String userEmail,
    required String userMobile,
  }) async {
    name = userName;
    email = userEmail;
    mobile = userMobile;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(nameKey, userName);
    await prefs.setString(emailKey, userEmail);
    await prefs.setString(mobileKey, userMobile);

    isLoggedIn.value = true;
  }

  // ==========================================================
  // RESTORE SESSION
  // ==========================================================

  Future<bool> restoreSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool loggedIn = prefs.getBool(loginKey) ?? false;

    if (loggedIn) {
      name = prefs.getString(nameKey) ?? '';
      email = prefs.getString(emailKey) ?? '';
      mobile = prefs.getString(mobileKey) ?? '';

      isLoggedIn.value = true;

      return true;
    }

    name = '';
    email = '';
    mobile = '';

    isLoggedIn.value = false;

    return false;
  }

  // ==========================================================
  // CONTINUE AS GUEST
  // ==========================================================

  Future<void> continueAsGuest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, false);

    name = '';
    email = '';
    mobile = '';

    isLoggedIn.value = false;
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(loginKey);
    await prefs.remove(nameKey);
    await prefs.remove(emailKey);
    await prefs.remove(mobileKey);

    name = '';
    email = '';
    mobile = '';

    isLoggedIn.value = false;
  }
}
