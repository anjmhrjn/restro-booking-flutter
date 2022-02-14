class UserDetails {
  final String? userId;
  final String? username;
  final String? email;
  final String? user_type;
  final String? token;
  final String? user_image;

  UserDetails({
    this.userId,
    this.username,
    this.email,
    this.user_type,
    this.token,
    this.user_image,
  });

  String get getUsername => username!;

  factory UserDetails.fromJson(Map<String, dynamic> responseData) {
    return UserDetails(
      userId: responseData['userId'],
      username: responseData['username'],
      email: responseData['email'],
      user_type: responseData['user_type'],
      token: responseData['token'],
      user_image: responseData['user_image'],
    );
  }
}
