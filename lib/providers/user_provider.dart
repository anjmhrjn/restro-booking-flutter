import 'package:flutter/cupertino.dart';
import 'package:restro_booking/model/userDetails.dart';
import 'package:restro_booking/utility/shared_preference.dart';

class UserProvider extends ChangeNotifier {
  UserDetails _user = UserDetails();
  bool _isAuthenticated = false;

  UserDetails get user => _user;

  void setUser(UserDetails user) {
    _user = user;
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  void setIsAuthenticated(bool newVal) {
    _isAuthenticated = newVal;
    notifyListeners();
  }
}
