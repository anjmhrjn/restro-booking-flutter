import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class ItemProvider extends ChangeNotifier {
  List<ItemModel> _item = [];

  List<ItemModel> get item => _item;

  Future<String> uploadImage(String filepath, String id, String token) async {
    try {
      String route = '/item/' + id + '/add-item-image/';
      String url = AppUrl.baseUrl + route;
      var request = MultipartRequest('PUT', Uri.parse(url));
      //using the token in the headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      // need a filename

      var ss = filepath.split('/').last;
      // adding the file in the request
      request.files.add(
        MultipartFile(
          'file',
          File(filepath).readAsBytes().asStream(),
          File(filepath).lengthSync(),
          filename: ss,
        ),
      );

      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return 'ok';
      }
    } catch (err) {
      print('$err');
    }
    return 'something goes wrong';
  }

  Future<bool> addItem(ItemModel itemData, String token, File? file) async {
    String s = '';
    final itemMap = itemData.toJson();
    itemMap.removeWhere((key, value) => key == "_id" || key == "images");
    String tok = 'Bearer $token';

    try {
      String tok = 'Bearer $token';
      final response = await post(
        Uri.parse(AppUrl.addItem),
        body: itemMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        // if (file != null) {
        //   var jsonData = jsonDecode(response.body) as Map;
        //   s = await uploadImage(file.path, jsonData['data']['_id'], token);
        // }
        // if (s == 'ok') {
        //   return true;
        // }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateItem(ItemModel itemData, String token) async {
    final Map<String, dynamic> itemMap = itemData.toJson();
    itemMap.remove("_id");
    itemMap.remove("categories");
    itemMap.remove("images");
    itemMap.remove("category_info");
    itemMap.remove("user_info");
    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.updateItem + itemData.id),
        body: itemMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var itemRes = jsonDecode(response.body) as Map;
        return itemRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<ItemModel>> getMyItemsData(token) async {
    List<ItemModel> result = [];
    String tok = 'Bearer $token';
    try {
      final response = await get(
        Uri.parse(AppUrl.myItems),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        ItemModel item;
        Iterable l = json.decode(response.body);
        for (var m in l) {
          item = ItemModel.fromJson(m);
          result.add(item);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<List<ItemModel>> getRestaurantItems(restroId, token) async {
    List<ItemModel> result = [];
    String tok = 'Bearer $token';
    final response = await get(
      Uri.parse(AppUrl.getRestroItems + restroId),
      headers: {
        'Authorization': tok,
      },
    );
    if (response.statusCode == 200) {
      ItemModel item;
      Map<String, dynamic> resData =
          json.decode(response.body) as Map<String, dynamic>;
      Iterable l = resData["items"];
      for (var m in l) {
        item = ItemModel.fromJson(m);
        result.add(item);
      }
    }
    return result;
    try {
      final response = await get(
        Uri.parse(AppUrl.getRestroItems + restroId),
        headers: {
          'Authorization': tok,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        ItemModel item;
        Iterable l = json.decode(response.body);
        for (var m in l) {
          item = ItemModel.fromJson(m);
          result.add(item);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> deleteItem(itemId, token) async {
    String tok = 'Bearer $token';
    try {
      final response = await delete(
        Uri.parse(AppUrl.deleteItem + itemId),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 204) {
        _item.removeWhere((element) => element.id == itemId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  ItemModel findById(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  getMyItems(token) async {
    _item = await getMyItemsData(token);
    notifyListeners();
  }

  setRestroItems(restroId, token) async {
    _item = await getRestaurantItems(restroId, token);
    notifyListeners();
  }
}
