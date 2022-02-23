import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class UserProfileProvider extends ChangeNotifier {
  User _userProfile = User();

  User get userProfile => _userProfile;

  Future<User> getUserProfile(userId, token) async {
    User result = User();
    String tok = 'Bearer $token';
    try {
      final response = await get(
        Uri.parse(AppUrl.getProfile + userId),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        result = User.fromJson(json.decode(response.body));
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> updateProfile(User userData, String token) async {
    final Map<String, dynamic> userMap = userData.toJson();
    userMap.removeWhere((key, value) => key == "_id");
    userMap.removeWhere((key, value) => key == "username");
    userMap.removeWhere((key, value) => key == "email");
    userMap.removeWhere((key, value) => key == "password");
    userMap.removeWhere((key, value) => key == "user_type");
    userMap.removeWhere((key, value) => key == "age");
    userMap.removeWhere((key, value) => key == "user_image");
    userMap.removeWhere((key, value) => key == "address");
    userMap.removeWhere((key, value) => key == "gender");
    userMap.removeWhere((key, value) => key == "tables");
    userMap.removeWhere((key, value) => key == "isActive");
    userMap.removeWhere((key, value) => key == "isSuperUser");
    userMap.removeWhere((key, value) => key == "isVerified");
    userMap.removeWhere((key, value) => key == "firstLogin");
    userMap.removeWhere((key, value) => key == "tags");

    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.updateProfile + userData.username!),
        body: userMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var userRes = jsonDecode(response.body) as Map;
        return userRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(Map<String, dynamic> pswData, token) async {
    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.changePsw),
        body: pswData,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var userRes = jsonDecode(response.body) as Map;
        return userRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void setUserProfile(userId, token) async {
    _userProfile = await getUserProfile(userId, token);
    notifyListeners();
  }
}
