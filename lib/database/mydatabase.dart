import 'dart:async';
import 'package:floor/floor.dart';
import 'package:restro_booking/dao/tabledao.dart';
import 'package:restro_booking/entity/table_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'mydatabase.g.dart';

@Database(version: 1, entities: [TableEntity])
abstract class AppDatabase extends FloorDatabase {
  TableDao get tableDao;
}
