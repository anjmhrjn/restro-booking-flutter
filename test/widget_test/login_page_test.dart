import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/providers/user_profile_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/login.dart';

void main() {
  testWidgets('Login Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: MaterialApp(home: LoginScreen()),
    ));

    final titlefinder = find.text('SIGN IN');
    final usernameFinder = find.byKey(Key('username'));
    final passwordFinder = find.byKey(Key('password'));

    expect(titlefinder, findsOneWidget);
    expect(usernameFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);
  });
}
