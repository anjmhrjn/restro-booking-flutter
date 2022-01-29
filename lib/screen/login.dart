import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/userDetails.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    color: Color(0xFF004194),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                      bottom: Radius.circular(35),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                        fontSize: 40,
                        // fontWeight: FontWeight.bold,
                        color: Color(0xFFF6F2EC),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F2EC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF004194).withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            username = value!;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F2EC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF004194).withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            password = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final Future<Map<String, dynamic>> response =
                                auth.login(username, password);
                            response.then((response) {
                              if (response['status']) {
                                UserDetails user = response['user'];
                                Provider.of<UserProvider>(
                                  context,
                                  listen: false,
                                ).setUser(user);
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/dashboard',
                                );
                                MotionToast.success(
                                  description: Text('Log in Success!'),
                                ).show(context);
                              } else {
                                MotionToast.error(
                                  description: Text(response['message']),
                                ).show(context);
                              }
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Login',
                              textScaleFactor: 1.2,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.send_rounded,
                              size: 19,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF004194),
                          minimumSize: const Size(double.infinity, 40),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          SizedBox(
                            width: 3,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text('Sign up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
