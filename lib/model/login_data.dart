import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginData extends ChangeNotifier {
  static late SharedPreferences _sharedPref;
  String? _mail;
  String? get mail => _mail;

  /// Shared Preferences Methods
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> saveEmailToSharedPref(String value) async {
    await _sharedPref.setString('email', value);
  }

  void loadEmailFromSharedPref() {
    _mail = _sharedPref.getString('email');
  }

  Future<void> deleteEmailFromSharedPref() async {
    await _sharedPref.remove('email');
  }
}
