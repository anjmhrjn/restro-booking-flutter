import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';

Widget getBusinessBottomNavBar(context) {
  var navRoutes = [
    '/dashboard',
    '/table-screen',
    '/item-screen',
    '/business-bookings',
    '/restro-profile'
  ];
  final btmProvider = Provider.of<BottomNavigationBarProvider>(context);
  return (BottomNavigationBar(
    currentIndex: btmProvider.currentIndex,
    onTap: (index) {
      btmProvider.currentIndex = index;
      Navigator.pushNamed(context, navRoutes[btmProvider.currentIndex]);
    },
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.table_chart_rounded),
        label: 'Table',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book_rounded),
        label: 'Menu',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book_rounded),
        label: 'Bookings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: 'Account',
      ),
    ],
    // items: [
    //   BottomNavigationBarItem(
    //     icon: new Icon(Icons.home),
    //     title: new Text('Home'),
    //   ),
    //   BottomNavigationBarItem(
    //     icon: new Icon(Icons.person),
    //     title: new Text('Profile'),
    //   ),
    //   BottomNavigationBarItem(
    //     icon: Icon(Icons.settings),
    //     title: Text('Settings'),
    //   )
    // ],
  ));

  // BottomNavigationBar(
  // currentIndex: btmProvider.currentIndex,
  // onTap: (index) {
  //   btmProvider.currentIndex = index;
  //   Navigator.pushNamed(context, navRoutes[btmProvider.currentIndex]);
  // },
  // selectedItemColor: Colors.amber,
  //   items: [
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: 'Home',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.table_chart_rounded),
  //       label: 'Table',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.menu_book_rounded),
  //       label: 'Menu',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.book_rounded),
  //       label: 'Bookings',
  //     ),
  //     BottomNavigationBarItem(
  //       icon: Icon(Icons.people),
  //       label: 'Account',
  //     ),
  //   ],
  // ));
}
