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
      price: json['price'].toString(),
      images: json['images'] as String?,
      description: json['description'] as String?,
      itemOf: json['itemOf'] as String?,
      category_info: (json['category_info'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user_info: json['user_info'] == null
          ? null
          : User.fromJson(json['user_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'categories': instance.categories,
      'price': instance.price,
      'images': instance.images,
      'description': instance.description,
      'itemOf': instance.itemOf,
      'category_info': instance.category_info?.map((e) => e.toJson()).toList(),
      'user_info': instance.user_info?.toJson(),
    };
