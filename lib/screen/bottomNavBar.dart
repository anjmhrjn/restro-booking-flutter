import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';

Widget getBusinessBottomNavBar(context) {
  var navRoutes = [
    '/dashboard',
    '/table-screen',
    '/item-screen',
    '/business-bookings',
    '/account'
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
        icon: Icon(Icons.person),
        label: 'Account',
      ),
    ],
  ));
}

Widget getCustomerBottomNavBar(context) {
  var navRoutes = [
    '/dashboard',
    '/restaurant',
    '/my-reservations',
    '/account',
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
        icon: Icon(Icons.food_bank_rounded),
        label: 'Restaurant',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book_online_outlined),
        label: 'Bookings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Account',
      ),
    ],
  ));
}

Widget getAdminBottomNavBar(context) {
  var navRoutes = ['/dashboard', '/restaurant', '/my-reservations', '/account'];
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
        icon: Icon(Icons.food_bank_rounded),
        label: 'Restaurant',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.book_online_outlined),
        label: 'Bookings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Account',
      ),
    ],
  ));
}
