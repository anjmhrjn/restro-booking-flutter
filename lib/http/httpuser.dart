import 'dart:convert';

import 'package:http/http.dart';

class HttpConnectUser {
  String baseurl = 'http://10.0.2.2:90/';
  String token = '';

  Future<bool> loginUser(String username, String password) async {
    Map<String, dynamic> userData = {
      'username': username,
      'password': password
    };

    try {
      final response = await post(
        Uri.parse(baseurl + "/user/login"),
        body: userData,
      );

      final jsonData = jsonDecode(response.body) as Map;
      token = jsonData['token'];

      if (token.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
