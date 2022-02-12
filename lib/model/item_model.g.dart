// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as String?,
      images: json['images'] as String?,
      description: json['description'] as String?,
      itemOf: json['itemOf'] as String?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'categories': instance.categories,
      'price': instance.price,
      'images': instance.images,
      'description': instance.description,
      'itemOf': instance.itemOf,
    };
