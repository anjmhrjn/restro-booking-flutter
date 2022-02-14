import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class RestaurantProvider extends ChangeNotifier {
  List<User> _restaurants = [];

  List<User> get restaurants => _restaurants;

  Future<List<User>> getAllRestaurantData(token) async {
    List<User> result = [];
    String tok = 'Bearer $token';
    try {
      final response = await get(
        Uri.parse(AppUrl.getAllBusiness),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        User restro;
        Iterable l = json.decode(response.body);
        for (var m in l) {
          restro = User.fromJson(m);
          result.add(restro);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<List<User>> searchRestaurantData(name, token) async {
    List<User> result = [];
    String tok = 'Bearer $token';
    try {
      final response = await get(
        Uri.parse(AppUrl.searchRestro + name),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        User restro;
        Iterable l = json.decode(response.body);
        for (var m in l) {
          restro = User.fromJson(m);
          result.add(restro);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  User findById(String id) {
    return _restaurants.firstWhere((element) => element.id == id);
  }

  void getAllRestaurants(token) async {
    _restaurants = await getAllRestaurantData(token);
    notifyListeners();
  }

  void searchRestaurant(name, token) async {
    _restaurants = await searchRestaurantData(name, token);
    notifyListeners();
  }
}
