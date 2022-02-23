import 'dart:convert';
// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/category_model.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _category = [];

  List<CategoryModel> get category => _category;

  Future<bool> addCategory(
      CategoryModel catData, String token, Client client) async {
    final Map<String, dynamic> categoryMap = {
      "name": catData.name,
    };
    try {
      String tok = 'Bearer $token';
      Response response = await client.post(
        Uri.parse(AppUrl.addCategory),
        body: categoryMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var categoryRes = jsonDecode(response.body) as Map;
        CategoryModel catData = CategoryModel(
          id: categoryRes['data']['_id'],
          name: categoryRes['data']['name'],
        );
        _category.add(catData);
        notifyListeners();
        return categoryRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Future<bool> updateTable(TableModel tableData, String token) async {
  //   final Map<String, dynamic> tableMap = {
  //     "min_capacity": tableData.min_capacity,
  //     "max_capacity": tableData.max_capacity,
  //     "table_number": tableData.table_number,
  //     "isAvailable": tableData.is_available.toString(),
  //     "tableOf": tableData.tableOf,
  //   };
  //   try {
  //     String tok = 'Bearer $token';
  //     Response response = await put(
  //       Uri.parse(AppUrl.updateTable + tableData.id),
  //       body: tableMap,
  //       headers: {'Authorization': tok},
  //     );
  //     if (response.statusCode == 200) {
  //       var tableRes = jsonDecode(response.body) as Map;
  //       return tableRes['success'];
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<List<CategoryModel>> getCategoryData() async {
    List<CategoryModel> result = [];
    try {
      final response = await get(
        Uri.parse(AppUrl.getCategory),
      );
      if (response.statusCode == 200) {
        CategoryModel item;
        Iterable l = json.decode(response.body);
        for (var m in l) {
          item = CategoryModel.fromJson(m);
          result.add(item);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> deleteCategory(categoryId, token) async {
    String tok = 'Bearer $token';
    try {
      final response = await delete(
        Uri.parse(AppUrl.deleteCategory + categoryId + "/"),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 204) {
        _category.removeWhere((element) => element.id == categoryId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  CategoryModel findById(String id) {
    return _category.firstWhere((element) => element.id == id);
  }

  CategoryModel findByIndex(int index) {
    return _category[index];
  }

  getCategories() async {
    _category = await getCategoryData();
    // print("Category $_category");
    notifyListeners();
  }
}
