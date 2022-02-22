import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/providers/auth_provider.dart';

import 'auth_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('loginuser', () {
    test('returns map value if the http call completes successfully for login',
        () async {
      final client = MockClient();
      when(client.post(
        Uri.parse(AppUrl.login),
        body: '{"username":"anuj1","password":"qpalzm10"}',
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
          // 'X-ApiKey' : 'ZGlzIzEyMw=='
        },
      )).thenAnswer((_) async => http.Response(
          // userdetails key is required in login function
          // it can contain dummy data but if it is not provided test fails
          '{"userdetails": {"userId": "1", "username": "anuj3", "email": "a@a.com", "user_type": "Business", "token": "a", "user_image": "a"}}',
          200));
      expect(
        await AuthProvider().login("anuj1", "qpalzm10", client),
        isA<Map<String, dynamic>>(),
      );
    });
  });
}
