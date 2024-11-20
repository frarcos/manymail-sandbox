import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageKey {
  accountCredentials,
}

class LocalStorageService {
  static setAccountCredentials({
    required String username,
    required String password,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      'accountCredentials',
      jsonEncode(
        {
          'username': username,
          'password': password,
        },
      ),
    );
  }

  static Future<Map<String, String>?> getAccountCredentials() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final String? accountCredentials = sharedPreferences.getString('accountCredentials');
      if (accountCredentials == null) {
        return null;
      }
      final decoded = jsonDecode(accountCredentials);
      if (decoded is Map<String, dynamic>) {
        return decoded.map((key, value) => MapEntry(key, value.toString()));
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
