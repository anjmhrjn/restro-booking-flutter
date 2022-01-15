import 'package:flutter/material.dart';
import 'package:restro_booking/screen/book.dart';
import 'package:restro_booking/screen/login.dart';
import 'package:restro_booking/screen/register.dart';

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
      home: BookTable(),
    );
  }
}
