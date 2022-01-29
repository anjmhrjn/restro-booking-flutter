import 'package:restro_booking/model/userModel.dart';

class UserDetails {
  String? userId;
  String? username;
  String? email;
  String? user_type;
  String? token;

  UserDetails({
    this.userId,
    this.username,
    this.email,
    this.user_type,
    this.token,
  });

  factory UserDetails.fromJson(Map<String, dynamic> responseData) {
    return UserDetails(
      userId: responseData['userId'],
      username: responseData['username'],
      email: responseData['email'],
      user_type: responseData['user_type'],
      token: responseData['token'],
    );
  }
}
