import 'dart:convert';
// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _booking = [];

  List<BookingModel> get booking => _booking;

  Future<bool> addItem(BookingModel bookingData, String token) async {
    final bookingMap = bookingData.toJson();
    bookingMap.removeWhere((key, value) => key == "_id");
    try {
      String tok = 'Bearer $token';
      final response = await post(
        Uri.parse(AppUrl.bookTable),
        body: bookingMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBooking(BookingModel bookingData, String token) async {
    final Map<String, dynamic> bookingMap = bookingData.toJson();
    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.updateBooking + bookingData.id),
        body: bookingMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var bookingRes = jsonDecode(response.body) as Map;
        return bookingRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBookingStatus(
      BookingModel bookingData, String token) async {
    final Map<String, dynamic> bookingMap = {
      "booking_status": bookingData.booking_status,
    };
    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.updateBookingStatus + bookingData.id),
        body: bookingMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var bookingRes = jsonDecode(response.body) as Map;
        return bookingRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<BookingModel>> getBusinessBooking(token) async {
    List<BookingModel> result = [];
    String tok = 'Bearer $token';

    try {
      final response = await get(
        Uri.parse(AppUrl.businessBooking),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        BookingModel bookData;
        List<dynamic> l = json.decode(response.body);
        for (var m in l) {
          print(m);
          bookData = BookingModel.fromJson(m);
          result.add(bookData);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> deleteBooking(itemId, token) async {
    String tok = 'Bearer $token';
    try {
      final response = await delete(
        Uri.parse(AppUrl.deleteItem + itemId),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 204) {
        _booking.removeWhere((element) => element.id == itemId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  BookingModel findById(String id) {
    return _booking.firstWhere((element) => element.id == id);
  }

  setBusinessBooking(token) async {
    _booking = await getBusinessBooking(token);
    notifyListeners();
  }
}
