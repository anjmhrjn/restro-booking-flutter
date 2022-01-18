import 'package:flutter/material.dart';

class RestroProfile extends StatelessWidget {
  const RestroProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     'images/restro.png',
                  //   ),
                  //   fit: BoxFit.fill,
                  // ),
                  color: Color(0xFFF6F2EC),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(35),
                  ),
                ),
                child: Image.asset(
                  'images/test.png',
                  width: 600.0,
                  height: 240.0,
                  fit: BoxFit.fill,
                ),
                // child: Image(
                //   image: AssetImage('images/sunset.png'),
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
