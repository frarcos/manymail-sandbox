import 'package:flutter/material.dart';
import 'package:sandbox/data-layer/models/standard_response.dart';
import 'package:sandbox/data-layer/services/account_service.dart';
import 'package:sandbox/data-layer/services/local_storage_service.dart';

class AccountProvider extends ChangeNotifier {
  bool isLoading = false;
  String? username;
  String? password;

  void setAccount({
    String? currentUsername,
    String? currentPassword,
  }) {
    username = currentUsername ?? username;
    password = currentPassword ?? password;
  }

  Future<bool> isLoggedIn() async {
    Map<String, String>? savedCredentials = await LocalStorageService.getAccountCredentials();
    return savedCredentials != null;
  }

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();
    final StandardResponse? standardResponse = await AccountService.login(
      username: username ?? '',
      password: password ?? '',
    );
    if (standardResponse?.success ?? false) {
      await LocalStorageService.setAccountCredentials(
        username: username!,
        password: password!,
      );
    }
    isLoading = false;
    notifyListeners();
    return standardResponse?.success ?? false;
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();
    await LocalStorageService.clear();
    isLoading = false;
    notifyListeners();
  }

  void clear() {
    isLoading = false;
    username = null;
    password = null;
  }
}
