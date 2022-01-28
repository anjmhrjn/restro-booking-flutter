import 'package:shared_preferences/shared_preferences.dart';
import 'package:restro_booking/model/userDetails.dart';

class UserPreferences {
  Future<bool> saveUser(UserDetails user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.userId!);
    prefs.setString('username', user.username!);
    prefs.setString('email', user.email!);
    prefs.setString('user_type', user.user_type!);
    prefs.setString('token', user.token!);
    prefs.setBool('isAuthenticated', true);

    return prefs.commit();
  }

  Future<UserDetails> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt('userId');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? user_type = prefs.getString('username');
    String? token = prefs.getString('token');
    bool? isAuthenticated = prefs.getBool('isAuthenticated');

    return UserDetails(
      userId: userId,
      username: username,
      email: email,
      user_type: user_type,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('user_type');
    prefs.remove('token');
    prefs.remove('isAuthenticated');
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

  Future<bool> getAuthenticatedStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAuthenticated = prefs.getBool('isAuthenticated');
    if (isAuthenticated != null) {
      return isAuthenticated;
    } else {
      return false;
    }
  }
}
