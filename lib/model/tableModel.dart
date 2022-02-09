class TableModel {
  final String id;
  final String? min_capacity;
  final String? max_capacity;
  final bool? is_available;
  final String? table_number;
  final String? tableOf;

  TableModel({
    this.id = '',
    this.min_capacity,
    this.max_capacity,
    this.is_available,
    this.table_number,
    this.tableOf,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['_id'],
      min_capacity: json['min_capacity'].toString(),
      max_capacity: json['max_capacity'].toString(),
      is_available: json['isAvailable'],
      table_number: json['table_number'].toString(),
      tableOf: json['tableOf'],
    );
  }
}