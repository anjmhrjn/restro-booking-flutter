// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['_id'] as String? ?? '',
      requested_for: json['requested_for'] as String?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      total_seats: json['total_seats'] as String?,
      table: json['table'] as String?,
      user: json['user'] as String?,
      booking_status: json['booking_status'] as String? ?? '',
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requested_for': instance.requested_for,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'total_seats': instance.total_seats,
      'table': instance.table,
      'user': instance.user,
      'booking_status': instance.booking_status,
    };
