import 'package:restro_booking/model/userModel.dart';

class UserDetails {
  int? userId;
  String? username;
  String? email;
  String? name;
  String? user_type;
  String? token;

  UserDetails({
    this.userId,
    this.username,
    this.email,
    this.name,
    this.user_type,
    this.token,
  });

  factory UserDetails.fromJson(Map<String, dynamic> responseData) {
    return UserDetails(
      userId: responseData['id'],
      username: responseData['username'],
      email: responseData['email'],
      name: responseData['name'],
      user_type: responseData['user_type'],
      token: responseData['token'],
    );
  }
}
