import 'package:json_annotation/json_annotation.dart';

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

  User({
    this.id = '',
    this.username = '',
    this.password = '',
    this.email = '',
    this.user_type = '',
    this.name = '',
    this.bio = '',
    this.user_image = '',
    this.address = '',
    this.phone = '',
    this.isSuperUser = false,
    this.isActive = false,
    this.isVerified = false,
    this.firstLogin = false,
    this.age = '',
    this.gender = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
