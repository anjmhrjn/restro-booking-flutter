import 'package:json_annotation/json_annotation.dart';
import 'package:restro_booking/model/category_model.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/model/table_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? user_type;
  final String? name;
  final String? bio;
  final String? user_image;
  final String? address;
  final String? phone;
  final bool isSuperUser;
  final bool isActive;
  final bool isVerified;
  final bool firstLogin;
  final String? age;
  final String? gender;
  final List<TableModel>? tables;
  final List<String>? tags;
  final String? opening_time;
  final String? closing_time;
  // final List<ItemModel>? items;

  User({
    this.id,
    this.username,
    this.password,
    this.email,
    this.user_type,
    this.name,
    this.bio,
    this.user_image,
    this.address,
    this.phone,
    this.isSuperUser = false,
    this.isActive = false,
    this.isVerified = false,
    this.firstLogin = false,
    this.age,
    this.gender,
    this.tables,
    this.tags,
    this.opening_time,
    this.closing_time,
    // this.items,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
