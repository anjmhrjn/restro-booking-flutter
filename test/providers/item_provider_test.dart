import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/providers/item_provider.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/providers/booking_provider.dart';

import 'item_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('item', () {
    test(
        'returns bool value if the http call completes successfully for making reservation',
        () async {
      ItemModel itemData = ItemModel(
        id: "1",
        name: "test",
        price: "123",
      );
      final itemMap = itemData.toJson();
      itemMap.remove("_id");
      itemMap.remove("categories");
      itemMap.remove("images");
      itemMap.remove("category_info");
      itemMap.remove("user_info");
      final client = MockClient();
      when(client.put(
        Uri.parse(AppUrl.updateItem + "1"),
        body: itemMap,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('{"success": true}', 200));
      expect(
        await ItemProvider().updateItem(itemData, "a", client),
        isA<bool>(),
      );
    });
  });
}
