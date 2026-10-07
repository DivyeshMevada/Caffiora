import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressState {
  AddressState._();

  static final AddressState instance = AddressState._();

  // ==========================================================
  // ADDRESS LIST
  // ==========================================================

  final ValueNotifier<List<Map<String, dynamic>>> addresses =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  static const String addressKey = 'saved_addresses';

  // ==========================================================
  // LOAD ADDRESSES
  // ==========================================================

  Future<void> loadAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString(addressKey);

    if (data == null || data.isEmpty) {
      addresses.value = [
        {
          'name': 'Raj Patel',
          'address': 'Raj, Silver Stone St: 2,\n'
              'Nana Mova Road, Rajkot, 360004',
          'phone': '9798347684',
          'type': 'Home',
        },
      ];

      await _save();
      return;
    }

    try {
      final List<dynamic> decoded = jsonDecode(data) as List<dynamic>;

      addresses.value = decoded
          .map(
            (item) => Map<String, dynamic>.from(
              item as Map,
            ),
          )
          .toList();
    } catch (e) {
      addresses.value = [];
    }
  }

  // ==========================================================
  // SAVE TO SHARED PREFERENCES
  // ==========================================================

  Future<void> _save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      addressKey,
      jsonEncode(addresses.value),
    );
  }

  // ==========================================================
  // ADD ADDRESS
  // ==========================================================

  Future<void> addAddress({
    required String name,
    required String address,
    required String phone,
    required String type,
  }) async {
    final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
      addresses.value,
    );

    list.add({
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
    });

    addresses.value = list;

    await _save();
  }

  // ==========================================================
  // UPDATE ADDRESS
  // ==========================================================

  Future<void> updateAddress({
    required int index,
    required String name,
    required String address,
    required String phone,
    required String type,
  }) async {
    final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
      addresses.value,
    );

    if (index < 0 || index >= list.length) {
      return;
    }

    list[index] = {
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
    };

    addresses.value = list;

    await _save();
  }

  // ==========================================================
  // DELETE ADDRESS
  // ==========================================================

  Future<void> deleteAddress(int index) async {
    final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(
      addresses.value,
    );

    if (index < 0 || index >= list.length) {
      return;
    }

    list.removeAt(index);

    addresses.value = list;

    await _save();
  }

  // ==========================================================
  // CLEAR ALL
  // ==========================================================

  Future<void> clearAddresses() async {
    addresses.value = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(addressKey);
  }
}
