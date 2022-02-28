import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/user_profile_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/utility/shared_preference.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formkey = GlobalKey<FormState>();
  String old_password = '';
  String new_password = '';
  String confirm_password = '';
  @override
  Widget build(BuildContext context) {
    final usrMdl = Provider.of<UserProvider>(context);
    final prfMdl = Provider.of<UserProfileProvider>(context);
    final btmProvider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Change Password',
                      textScaleFactor: 2,
                      style: TextStyle(letterSpacing: 4),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    key: Key('oldpsw'),
                    obscureText: true,
                    onSaved: (value) {
                      old_password = value!;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Old Password",
                      labelText: "Old Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      new_password = value!;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "New Password",
                      labelText: "New Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      confirm_password = value!;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.check_box_outlined),
                    label: Text('Change Password'),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();

                        Map<String, dynamic> passwordData = {
                          "oldPassword": old_password,
                          "newPassword": new_password
                        };

                        var response = await prfMdl.changePassword(
                            passwordData, usrMdl.user.token);

                        if (response) {
                          usrMdl.setIsAuthenticated(false);
                          UserPreferences().removeUser();
                          btmProvider.currentIndex = 0;
                          Navigator.pushNamed(context, '/login');
                          MotionToast.success(
                            description: Text('Password Changed'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Error in changing password'),
                          ).show(context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF004194),
                      minimumSize: const Size(double.infinity, 40),
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
