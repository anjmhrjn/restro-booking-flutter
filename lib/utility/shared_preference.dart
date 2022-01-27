import 'package:shared_preferences/shared_preferences.dart';
import 'package:restro_booking/model/userDetails.dart';

class UserPreferences {
  Future<bool> saveUser(UserDetails user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.userId!);
    prefs.setString('username', user.username!);
    prefs.setString('email', user.email!);
    prefs.setString('name', user.name!);
    prefs.setString('user_type', user.user_type!);
    prefs.setString('token', user.token!);

    return prefs.commit();
  }

  Future<UserDetails> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt('userId');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? name = prefs.getString('name');
    String? user_type = prefs.getString('username');
    String? token = prefs.getString('token');

    return UserDetails(
      userId: userId,
      username: username,
      email: email,
      name: name,
      user_type: user_type,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('name');
    prefs.remove('user_type');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      return token;
    } else {
      return '';
    }
  }
}
