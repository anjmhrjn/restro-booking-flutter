import 'dart:convert';
// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/utility/app_url.dart';

class TableProvider extends ChangeNotifier {
  List<TableModel> _table = [];

  List<TableModel> get table => _table;

  Future<bool> addTable(TableModel tableData, String token) async {
    final Map<String, dynamic> tableMap = {
      "min_capacity": tableData.min_capacity,
      "max_capacity": tableData.max_capacity,
      "table_number": tableData.table_number,
      "tableOf": tableData.tableOf,
    };
    try {
      String tok = 'Bearer $token';
      Response response = await post(
        Uri.parse(AppUrl.tableAdd),
        body: tableMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var tableRes = jsonDecode(response.body) as Map;
        return tableRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTable(TableModel tableData, String token) async {
    final Map<String, dynamic> tableMap = {
      "min_capacity": tableData.min_capacity,
      "max_capacity": tableData.max_capacity,
      "table_number": tableData.table_number,
      "isAvailable": tableData.is_available.toString(),
      "tableOf": tableData.tableOf,
    };
    // String tok = 'Bearer $token';
    // print(tok);
    // print(AppUrl.updateTable + tableData.id);
    // Response response = await put(
    //   Uri.parse(AppUrl.updateTable + tableData.id),
    //   body: tableMap,
    //   headers: {'Authorization': tok},
    // );
    try {
      String tok = 'Bearer $token';
      Response response = await put(
        Uri.parse(AppUrl.updateTable + tableData.id),
        body: tableMap,
        headers: {'Authorization': tok},
      );
      if (response.statusCode == 200) {
        var tableRes = jsonDecode(response.body) as Map;
        return tableRes['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<TableModel>> getMyTablesData(userId, token) async {
    List<TableModel> result = [];
    String tok = 'Bearer $token';
    try {
      final response = await get(
        Uri.parse(AppUrl.myTables + userId + "/"),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        TableModel item;
        Iterable l = json.decode(response.body);
        var i = 0;
        for (var m in l) {
          item = TableModel.fromJson(m);
          result.add(item);
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> deleteTable(tableId, token) async {
    String tok = 'Bearer $token';
    try {
      final response = await delete(
        Uri.parse(AppUrl.deleteTable + tableId + "/"),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 204) {
        _table.removeWhere((element) => element.id == tableId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  TableModel findById(String id) {
    return _table.firstWhere((element) => element.id == id);
  }

  getMyTables(userId, token) async {
    _table = await getMyTablesData(userId, token);
    notifyListeners();
  }
}
