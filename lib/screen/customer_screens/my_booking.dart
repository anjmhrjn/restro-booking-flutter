import 'package:flutter/material.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F2EC),
        body: SafeArea(
          child: SingleChildScrollView(),
        ),
        bottomNavigationBar: getCustomerBottomNavBar(context));
  }
}
