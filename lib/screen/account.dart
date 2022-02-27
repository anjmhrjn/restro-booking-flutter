import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/utility/shared_preference.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:proximity_sensor/proximity_sensor.dart';

// import 'package:all_sensors/all_sensors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
      if (_isNear) {
        MotionToast.warning(description: Text('Too Close to the screen'))
            .show(context);
      }
    });
  }
  // bool _proximityValues = false;
  // List<StreamSubscription<dynamic>> _streamSubscriptions =
  //     <StreamSubscription<dynamic>>[];

  // @override
  // void dispose() {
  //   super.dispose();
  //   for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
  //     subscription.cancel();
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _streamSubscriptions.add(proximityEvents.listen((ProximityEvent event) {
  //     setState(() {
  //       _proximityValues = event.getValue();
  //     });
  //     print(_proximityValues);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    final usrMdl = Provider.of<UserProvider>(context);
    final btmProvider =
        Provider.of<BottomNavigationBarProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: usrMdl.user.user_image == null ||
                          usrMdl.user.user_image == ''
                      ? NetworkImage(AppUrl.baseUrl + "/account.png")
                      : NetworkImage(
                          AppUrl.baseUrl + "/${usrMdl.user.user_image}"),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  usrMdl.user.username!.toUpperCase(),
                  textScaleFactor: 1.5,
                  style: TextStyle(letterSpacing: 4),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  usrMdl.user.user_type!.toUpperCase(),
                  textScaleFactor: 1,
                  style: TextStyle(letterSpacing: 4),
                ),
                Divider(
                  height: 20,
                  // thickness: 1,
                  color: Colors.black,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/update-profile');
                  },
                  icon: Icon(Icons.person_sharp),
                  label: Text('Edit Profile'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size(double.infinity, 40),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/change-psw');
                  },
                  icon: Icon(Icons.settings),
                  label: Text('Setting'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size(double.infinity, 40),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton.icon(
                  onPressed: () {
                    usrMdl.setIsAuthenticated(false);
                    UserPreferences().removeUser();
                    btmProvider.currentIndex = 0;
                    Navigator.pushNamed(context, '/login');
                    MotionToast.success(description: Text('Logging you out!'))
                        .show(context);
                  },
                  icon: Icon(Icons.logout_outlined),
                  label: Text('Logout'),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: const Size(double.infinity, 40),
                    padding: EdgeInsets.all(10),
                  ),
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
