import 'package:floor/floor.dart';
import 'package:restro_booking/entity/table_entity.dart';

@dao
abstract class TableDao {
  @Query('Select * from TableEntity')
  Future<List<TableEntity>> findAllTables();

  @Query('Select * from TableEntity Where id= :id')
  Future<TableEntity?> findTableById(String id);

  @Query('Select * from TableEntity Where tableOf= :tableOf')
  Future<List<TableEntity>> findBusinessTables(String tableOf);

  @insert
  Future<int> insertTables(TableEntity table);

  @Query('Delete from TableEntity')
  Future<int?> deleteBusinessTables();
}
