// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      user_type: json['user_type'] as String?,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      user_image: json['user_image'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      isSuperUser: json['isSuperUser'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      firstLogin: json['firstLogin'] as bool? ?? false,
      age: json['age'] as String?,
      gender: json['gender'] as String?,
      tables: (json['tables'] as List<dynamic>?)
          ?.map((e) => TableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      opening_time: json['opening_time'] as String?,
      closing_time: json['closing_time'] as String?,
      // items: (json['items'] as List<dynamic>?)
      //     ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
      //     .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'user_type': instance.user_type,
      'name': instance.name,
      'bio': instance.bio,
      'user_image': instance.user_image,
      'address': instance.address,
      'phone': instance.phone,
      'isSuperUser': instance.isSuperUser,
      'isActive': instance.isActive,
      'isVerified': instance.isVerified,
      'firstLogin': instance.firstLogin,
      'age': instance.age,
      'gender': instance.gender,
      'tables': instance.tables,
      'tags': instance.tags,
      'opening_time': instance.opening_time,
      'closing_time': instance.closing_time,
      // 'items': instance.items,
    };
