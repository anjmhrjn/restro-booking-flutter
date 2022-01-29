import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider usrMdl = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome ${usrMdl.user.username}!',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    color: Color(0xFF004194),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'How Are You Today?',
                  textScaleFactor: 1.3,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: getBusinessBottomNavBar(context),
    );
  }
}
