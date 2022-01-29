class TableModel {
  final String? min_capacity;
  final String? max_capacity;
  final bool? is_available;
  final String? table_number;
  final String? tableOf;

  TableModel({
    this.min_capacity,
    this.max_capacity,
    this.is_available,
    this.table_number,
    this.tableOf,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      min_capacity: json['min_capacity'],
      max_capacity: json['max_capacity'],
      is_available: json['is_available'],
      table_number: json['table_number'],
      tableOf: json['tableOf'],
    );
  }
}
