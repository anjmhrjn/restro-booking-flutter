import 'package:json_annotation/json_annotation.dart';
import 'package:restro_booking/model/user_model.dart';

part 'table_model.g.dart';

@JsonSerializable()
class TableModel {
  final String id;
  final String? min_capacity;
  final String? max_capacity;
  late final bool? is_available;
  final String? table_number;
  final String? tableOf;
  final User? user_detail;

  TableModel({
    this.id = '',
    this.min_capacity,
    this.max_capacity,
    this.is_available,
    this.table_number,
    this.tableOf,
    this.user_detail,
  });

  void setIsAvailable(bool value) {
    is_available = value;
  }

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
}
