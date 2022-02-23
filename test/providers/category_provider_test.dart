import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/model/category_model.dart';
import 'package:restro_booking/providers/category_provider.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/providers/booking_provider.dart';

import 'category_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('category', () {
    test(
        'returns bool value if the http call completes successfully for adding category',
        () async {
      CategoryModel categoryData = CategoryModel(name: "test");
      final Map<String, dynamic> categoryMap = {
        "name": categoryData.name,
      };
      final client = MockClient();
      when(client.post(
        Uri.parse(AppUrl.addCategory),
        body: categoryMap,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          '{"data":{"_id": "123", "name": "test"}, "success":true}', 200));
      expect(
        await CategoryProvider().addCategory(categoryData, "a", client),
        isA<bool>(),
      );
    });
  });
}
