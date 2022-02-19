import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/category_provider.dart';
import 'package:restro_booking/providers/item_provider.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/account.dart';
import 'package:restro_booking/screen/book.dart';
import 'package:restro_booking/screen/business_screens/add_category.dart';
import 'package:restro_booking/screen/business_screens/add_item.dart';
import 'package:restro_booking/screen/business_screens/booking_list.dart';
import 'package:restro_booking/screen/business_screens/myTables.dart';
import 'package:restro_booking/screen/business_screens/update_booking_status.dart';
import 'package:restro_booking/screen/business_screens/update_item.dart';
import 'package:restro_booking/screen/business_screens/update_table.dart';
import 'package:restro_booking/screen/business_screens/view_item.dart';
import 'package:restro_booking/screen/customer_screens/my_booking.dart';
import 'package:restro_booking/screen/customer_screens/reserve_table.dart';
import 'package:restro_booking/screen/customer_screens/restaurant_list.dart';
import 'package:restro_booking/screen/customer_screens/restro_tables.dart';
import 'package:restro_booking/screen/dashboard.dart';
import 'package:restro_booking/screen/business_screens/itemScreen.dart';
import 'package:restro_booking/screen/business_screens/table_add.dart';
import 'package:restro_booking/screen/login.dart';
import 'package:restro_booking/screen/customer_screens/menuList.dart';
import 'package:restro_booking/screen/register.dart';
import 'package:restro_booking/screen/restroList.dart';
import 'package:restro_booking/screen/customer_screens/restro_profile.dart';
import 'package:restro_booking/screen/business_screens/tableScreen.dart';
import 'package:restro_booking/screen/business_screens/table_bulk.dart';
import 'package:restro_booking/utility/shared_preference.dart';

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
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ItemProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/account': (context) => AccountScreen(),
          '/addTable': (context) => TableAdd(),
          '/bulkAddTable': (context) => TableBulkAdd(),
          '/restro-profile': (context) => RestroProfile(),
          '/restro-lists': (context) => RestroLists(),
          '/table-screen': (context) => TableScreen(),
          '/item-screen': (context) => ItemScreen(),
          '/dashboard': (context) => UserDashboard(),
          '/my-tables': (context) => MyTableScreen(),
          '/update-table': (context) => UpdateTableScreen(),
          '/add-item': (context) => AddItemScreen(),
          '/add-category': (context) => AddCategoryScreen(),
          '/my-items': (context) => ViewItemScreen(),
          '/update-item': (context) => UpdateItemScreen(),
          '/business-bookings': (context) => BusinessBookingList(),
          '/update-status': (context) => UpdateBookingStatusScreen(),

          // customer routes
          '/restaurant': (context) => RestaurantList(),
          '/my-reservations': (context) => MyBookingsScreen(),
          '/restro-tables': (context) => RestroTables(),
          '/reserve-table': (context) => ReserveTable(),
        },
        onGenerateRoute: (settings) {
          // If you push the PassArguments route
          if (settings.name == '/restro-items') {
            // Cast the arguments to the correct
            // type: ScreenArguments.
            final args = settings.arguments as Map;

            // Then, extract the required data from
            // the arguments and pass the data to the
            // correct screen.
            return MaterialPageRoute(
              builder: (context) {
                return MenuItems(
                  id: args['id'],
                );
              },
            );
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
        // home: BookTable(),
        // home: MenuItems(),
        // home: RestroProfile(), (used)
      ),
    );
  }
}
