import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/userDetails.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shake/shake.dart';

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
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        final usrMdl = Provider.of<UserProvider>(context, listen: false);
        final btmProvider =
            Provider.of<BottomNavigationBarProvider>(context, listen: false);
        usrMdl.setIsAuthenticated(false);
        UserPreferences().removeUser();
        btmProvider.currentIndex = 0;
        Navigator.pushNamed(context, '/login');
        MotionToast.success(
          description: Text('Logging you out!'),
        ).show(context);
      },
    );
    // ShakeDetector detector = ShakeDetector.waitForStart(
    //   onPhoneShake: () {
    //     // Do stuff on phone shake

    //   },
    // );
    // detector.startListening();
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
