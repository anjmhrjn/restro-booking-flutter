import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  final String id;
  final String? requested_for;
  final String? start_time;
  final String? end_time;
  final String? total_seats;
  final String? table;
  final String? user;
  final String? booking_status;

  BookingModel({
    this.id = '',
    this.requested_for,
    this.start_time,
    this.end_time,
    this.total_seats,
    this.table,
    this.user,
    this.booking_status = '',
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
