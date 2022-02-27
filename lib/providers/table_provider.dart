import 'dart:convert';
// import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restro_booking/database/database_instance.dart';
import 'package:restro_booking/entity/table_entity.dart';
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

  Future<bool> bulkTableAdd(TableModel tableData, String token) async {
    final Map<String, dynamic> tableMap = {
      "min_capacity": tableData.min_capacity,
      "max_capacity": tableData.max_capacity,
      "table_number": tableData.table_number,
      "tableOf": tableData.tableOf,
    };
    try {
      String tok = 'Bearer $token';
      Response response = await post(
        Uri.parse(AppUrl.tableBulkAdd),
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
      print(e);
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

  insertData(TableEntity tableData) async {
    final database = await DatabaseInstance.instance.getDatabaseInstance();
    await database.tableDao.insertTables(tableData);
  }

  Future<List<TableEntity>> fetchData(String tableOf) async {
    // final result = await widget.personDao.findAllPerson();
    var database = await DatabaseInstance.instance.getDatabaseInstance();
    var result = database.tableDao.findBusinessTables(tableOf);
    return result;
  }

  delTable() async {
    final database = await DatabaseInstance.instance.getDatabaseInstance();
    await database.tableDao.deleteBusinessTables();
  }

  Future<List<TableModel>> getMyTablesData(userId, token, Client client) async {
    delTable();
    List<TableModel> result = [];
    String tok = 'Bearer $token';
    final response = await client.get(
      Uri.parse(AppUrl.myTables + userId + "/"),
      headers: {
        'Authorization': tok,
      },
    );

    try {
      final response = await client.get(
        Uri.parse(AppUrl.myTables + userId + "/"),
        headers: {
          'Authorization': tok,
        },
      );
      if (response.statusCode == 200) {
        String tableOf = '';
        TableModel item;
        TableEntity te;
        Iterable l = json.decode(response.body);
        var i = 0;
        for (var m in l) {
          item = TableModel.fromJson(m);
          te = TableEntity.fromJson(m);
          insertData(te);
          tableOf = m['tableOf'];
        }
        List<TableEntity> tableData = await fetchData(tableOf);
        for (var td in tableData) {
          item = TableModel.fromJson(td.toJson());
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
    _table = await getMyTablesData(userId, token, Client());
    notifyListeners();
  }
}
