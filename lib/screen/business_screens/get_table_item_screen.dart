import 'package:flutter/material.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

Widget getTableItemScreen(context, Map<String, dynamic> attributes) {
  return Scaffold(
    backgroundColor: Color(0xFFF6F2EC),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text(
                      attributes['addBtnText'],
                      textScaleFactor: 1.2,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF004194),
                      // minimumSize: const Size(double.infinity, 40),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye_rounded),
                    label: Text(
                      attributes['viewBtnText'],
                      textScaleFactor: 1.2,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFEE6A3E),
                      // minimumSize: const Size(double.infinity, 40),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: getBusinessBottomNavBar(context),
  );
}
