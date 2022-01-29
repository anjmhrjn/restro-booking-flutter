import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restro_booking/model/userDetails.dart';
import 'package:restro_booking/model/userModel.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:http/http.dart';
import 'package:restro_booking/utility/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Map<String, dynamic>> register(User user) async {
    Map<String, dynamic> userMap = {
      "username": user.username,
      "email": user.email,
      "password": user.password,
      "user_type": user.user_type,
    };

    return await post(
      Uri.parse(AppUrl.register),
      body: userMap,
    ).then(onValue).catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static onValue(Response response) async {
    Map<String, dynamic> result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': 'Successfully registered',
      };
    } else {
      result = {
        'status': false,
        'message': responseData['message'],
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
        // 'X-ApiKey' : 'ZGlzIzEyMw=='
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['userdetails'];

      UserDetails authUser = UserDetails.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }

    return result;
  }

  static onError(error) {
    print("The error is ${error.detail}");
    return {
      "status": false,
      "message": "Registration failed",
      "data": error,
    };
  }
}
