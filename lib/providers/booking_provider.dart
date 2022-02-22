import 'dart:convert';
// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class BookingProvider extends ChangeNotifier {
  List<BookingModel> _booking = [];

  List<BookingModel> get booking => _booking;

  Future<bool> makeReservation(
      BookingModel bookingData, String token, Client client) async {
    final bookingMap = bookingData.toJson();
    bookingMap.removeWhere((key, value) => key == "_id");
    bookingMap.removeWhere((key, value) => key == "booking_status");
    bookingMap.removeWhere((key, value) => key == "table_detail");
    bookingMap.removeWhere((key, value) => key == "user_detail");
    try {
      String tok = 'Bearer $token';
      final response = await client.post(
        Uri.parse(AppUrl.bookTable),
        body: bookingMap,
        headers: {'Authorization': tok},
      );
      Map<String, dynamic> resp = json.decode(response.body);
      if (resp['success']) {
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
    bookingMap.removeWhere((key, value) => key == "_id");
    bookingMap.removeWhere((key, value) => key == "booking_status");
    bookingMap.removeWhere((key, value) => key == "table_detail");
    bookingMap.removeWhere((key, value) => key == "user_detail");

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
          bookData = BookingModel.fromJson(m);
          result.add(bookData);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<List<BookingModel>> getCustomerBooking(token) async {
    List<BookingModel> result = [];
    String tok = 'Bearer $token';

    try {
      final response = await get(
        Uri.parse(AppUrl.getMyBooking),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        BookingModel bookData;
        List<dynamic> l = json.decode(response.body);
        for (var m in l) {
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

  filterBooking(Map<String, dynamic> filterData, String token) async {
    String tok = 'Bearer $token';
    List<BookingModel> result = [];
    try {
      final response = await post(
        Uri.parse(AppUrl.filterBooking),
        body: filterData,
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        BookingModel bookData;
        List<dynamic> l = json.decode(response.body);
        for (var m in l) {
          bookData = BookingModel.fromJson(m);
          result.add(bookData);
        }
        _booking = result;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  BookingModel findById(String id) {
    return _booking.firstWhere((element) => element.id == id);
  }

  setBusinessBooking(token) async {
    _booking = await getBusinessBooking(token);
    notifyListeners();
  }

  setCustomerBooking(token) async {
    _booking = await getCustomerBooking(token);
    notifyListeners();
  }
}
