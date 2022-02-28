import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/providers/btmnavigation_provider.dart';
import 'package:restro_booking/providers/user_profile_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/dashboard.dart';
import 'package:restro_booking/screen/login.dart';

void main() {
  testWidgets('Dashboard Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
      ],
      child: MaterialApp(home: UserDashboard()),
    ));

    final titlefinder = find.text('How Are You Today?');

    expect(titlefinder, findsOneWidget);
  });
}
