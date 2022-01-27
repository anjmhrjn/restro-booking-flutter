import 'package:flutter/cupertino.dart';
import 'package:restro_booking/model/userDetails.dart';

class UserProvider extends ChangeNotifier {
  UserDetails _user = UserDetails();

  UserDetails get user => _user;

  void setUser(UserDetails user) {
    _user = user;
    notifyListeners();
  }
}
