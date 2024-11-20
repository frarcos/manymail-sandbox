import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sandbox/data-layer/services/local_storage_service.dart';

class NetworkService {
  static Future<http.Response> get(String url) async {
    Map<String, String>? credentials = await LocalStorageService.getAccountCredentials();
    String auth = base64Encode(utf8.encode('${credentials?['username']}:${credentials?['password']}'));
    return http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $auth',
      },
    );
  }

  static Future<http.Response> delete(String url) async {
    Map<String, String>? credentials = await LocalStorageService.getAccountCredentials();
    String auth = base64Encode(utf8.encode('${credentials?['username']}:${credentials?['password']}'));
    return http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Basic $auth',
      },
    );
  }
}
