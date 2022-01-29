import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/book.dart';
import 'package:restro_booking/screen/dashboard.dart';
import 'package:restro_booking/screen/business_screens/itemScreen.dart';
import 'package:restro_booking/screen/business_screens/table_add.dart';
import 'package:restro_booking/screen/login.dart';
import 'package:restro_booking/screen/menuList.dart';
import 'package:restro_booking/screen/register.dart';
import 'package:restro_booking/screen/restroList.dart';
import 'package:restro_booking/screen/restro_profile.dart';
import 'package:restro_booking/screen/business_screens/tableScreen.dart';
import 'package:restro_booking/screen/business_screens/table_bulk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TableProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/addTable': (context) => TableAdd(),
          '/restro-profile': (context) => RestroProfile(),
          '/restro-lists': (context) => RestroLists(),
          '/table-screen': (context) => TableScreen(),
          '/item-screen': (context) => ItemScreen(),
          '/dashboard': (context) => UserDashboard(),
        },
        // home: RegisterScreen(),
        // home: LoginScreen(),
        // home: BookTable(),
        // home: MenuItems(),
        // home: RestroLists(),
        // home: RestroProfile(),
        // home: TableAdd(),
        // home: TableBulkAdd(),
      ),
    );
  }
}
