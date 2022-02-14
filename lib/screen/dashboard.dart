import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/userDetails.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  getUserDetails() async {
    final UserDetails usrDetail = await UserPreferences().getUser();
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    usrMdl.setUser(usrDetail);
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

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
      bottomNavigationBar: usrMdl.user.user_type == 'Business'
          ? getBusinessBottomNavBar(context)
          : (usrMdl.user.user_type == 'Customer'
              ? getCustomerBottomNavBar(context)
              : getAdminBottomNavBar(context)),
    );
  }
}
