import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/auth_provider.dart';
import 'package:restro_booking/screen/register.dart';

void main() {
  testWidgets('Register Page Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(home: RegisterScreen()),
    ));

    final titlefinder = find.text('SIGN UP');
    final dropdownfinder = find.byKey(Key('dropdown'));

    expect(titlefinder, findsOneWidget);
    expect(dropdownfinder, findsOneWidget);
  });
}
