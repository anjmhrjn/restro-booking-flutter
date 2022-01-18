import 'package:flutter/material.dart';
import 'package:restro_booking/screen/book.dart';
import 'package:restro_booking/screen/login.dart';
import 'package:restro_booking/screen/menuList.dart';
import 'package:restro_booking/screen/register.dart';
import 'package:restro_booking/screen/restroList.dart';
import 'package:restro_booking/screen/restro_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: RegisterScreen(),
      // home: LoginScreen(),
      // home: BookTable(),
      // home: MenuItems(),
      // home: RestroLists(),
      home: RestroProfile(),
    );
  }
}
