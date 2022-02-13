// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableModel _$TableModelFromJson(Map<String, dynamic> json) => TableModel(
      id: json['id'] as String? ?? '',
      min_capacity: json['min_capacity'] as String?,
      max_capacity: json['max_capacity'] as String?,
      is_available: json['is_available'] as bool?,
      table_number: json['table_number'] as String?,
      tableOf: json['tableOf'] as String?,
      user_detail: json['user_detail'] == null
          ? null
          : User.fromJson(json['user_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TableModelToJson(TableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'min_capacity': instance.min_capacity,
      'max_capacity': instance.max_capacity,
      'is_available': instance.is_available,
      'table_number': instance.table_number,
      'tableOf': instance.tableOf,
      'user_detail': instance.user_detail,
    };
