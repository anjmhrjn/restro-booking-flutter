import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/user_profile_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/utility/shared_preference.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  void initState() {
    super.initState();
    final prfMdl = Provider.of<UserProfileProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    prfMdl.setUserProfile(usrMdl.user.userId, usrMdl.user.token);
  }

  String tags = '';
  String opening_time = '';
  String closing_time = '';
  final formkey = GlobalKey<FormState>();

  Widget renderBusinessFields() {
    return Column(
      children: [
        DateTimeFormField(
          initialValue: DateTime.parse(opening_time),
          mode: DateTimeFieldPickerMode.time,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            hintText: "Opening Time",
            labelText: "Opening Time",
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
          firstDate: DateTime.now(),
          initialDate: DateTime.now().add(
            const Duration(days: 10),
          ),
          onDateSelected: (DateTime value) {
            opening_time = value.toString();
          },
        ),
        SizedBox(
          height: 15,
        ),
        DateTimeFormField(
          initialValue: DateTime.parse(closing_time),
          mode: DateTimeFieldPickerMode.time,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            hintText: "Closing Time",
            labelText: "Closing Time",
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
          firstDate: DateTime.now(),
          initialDate: DateTime.now().add(
            const Duration(days: 10),
          ),
          onDateSelected: (DateTime value) {
            closing_time = value.toString();
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          initialValue: tags,
          onSaved: (value) {
            tags = value!;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            hintText: "Your Tags",
            labelText: "Tags",
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final prfMdl = Provider.of<UserProfileProvider>(context);
    final usrMdl = Provider.of<UserProvider>(context);
    User usrData = prfMdl.userProfile;
    String? name = usrData.name;
    String? bio = usrData.bio;
    String? phone = usrData.phone;
    opening_time = DateTime(2022).toString().split(" ")[0] +
        " " +
        usrData.opening_time.toString();
    closing_time = DateTime(2022).toString().split(" ")[0] +
        " " +
        usrData.closing_time.toString();
    tags = usrData.tags == null ? '' : usrData.tags!.join(",");

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
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: name,
                        onSaved: (value) {
                          name = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20,
                          ),
                          hintText: "Your Name",
                          labelText: "Name",
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
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: bio,
                        onSaved: (value) {
                          bio = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20,
                          ),
                          hintText: "Tel us about yourself",
                          labelText: "Bio",
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
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: phone,
                        onSaved: (value) {
                          phone = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 20,
                          ),
                          hintText: "Your Contact",
                          labelText: "Contact",
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
                        height: 15,
                      ),
                      usrMdl.user.user_type == 'Business'
                          ? renderBusinessFields()
                          : SizedBox(),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.check_box_outlined),
                        label: Text('Update'),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            String token = usrMdl.user.token!;
                            String userId = usrMdl.user.userId!;

                            User us = User(
                                username: usrMdl.user.username,
                                id: userId,
                                name: name,
                                bio: bio,
                                phone: phone,
                                opening_time: opening_time.split(" ")[1],
                                closing_time: closing_time.split(" ")[1],
                                tags: tags.split(","));
                            final bool response = await prfMdl.updateProfile(
                              us,
                              token,
                            );
                            // final bool response = false;
                            if (response) {
                              formkey.currentState!.reset();
                              MotionToast.success(
                                description: Text('Profile Updated'),
                              ).show(context);
                            } else {
                              MotionToast.error(
                                description: Text('Error in updating profile'),
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
