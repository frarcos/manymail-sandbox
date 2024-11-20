import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sandbox/constants/sandbox_network.dart';
import 'package:sandbox/data-layer/models/standard_response.dart';

class AccountService {
  static Future<StandardResponse?> login({
    required String username,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          '${SandboxNetwork.baseUrl}/account/validate',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      return StandardResponse.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}
