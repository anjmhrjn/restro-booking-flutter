import 'package:floor/floor.dart';

@entity
class TableEntity {
  @PrimaryKey(autoGenerate: true)
  int? pk;
  final String id;
  final String min_capacity;
  final String max_capacity;
  final bool is_available;
  final String table_number;
  final String tableOf;

  TableEntity({
    this.pk,
    required this.id,
    required this.min_capacity,
    required this.max_capacity,
    required this.is_available,
    required this.table_number,
    required this.tableOf,
  });

  TableEntity.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        min_capacity = json['min_capacity'].toString(),
        max_capacity = json['max_capacity'].toString(),
        is_available = json['isAvailable'],
        table_number = json['table_number'].toString(),
        tableOf = json['tableOf'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'min_capacity': min_capacity,
        'max_capacity': max_capacity,
        'isAvailable': is_available,
        'table_number': table_number,
        'tableOf': tableOf,
      };
}
