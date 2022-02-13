import 'package:json_annotation/json_annotation.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/model/user_model.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: '_id')
  final String id;
  final String? requested_for;
  final String? start_time;
  final String? end_time;
  final String? total_seats;
  final String? table;
  final String? user;
  final String? booking_status;
  final TableModel? table_detail;
  final User? user_detail;

  BookingModel({
    this.id = '',
    this.requested_for,
    this.start_time,
    this.end_time,
    this.total_seats,
    this.table,
    this.user,
    this.booking_status,
    this.table_detail,
    this.user_detail,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
