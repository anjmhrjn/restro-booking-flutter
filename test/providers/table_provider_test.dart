import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/providers/table_provider.dart';

import 'table_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getTablesData', () {
    test(
        'returns list of tables if the http call completes successfully for login',
        () async {
      final client = MockClient();
      when(client.get(
        Uri.parse(AppUrl.myTables + "1/"),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(
          '[{"_id":"1", "table_number":"2"}, {"_id":"1", "table_number":"2"}]',
          200));
      expect(
        await TableProvider().getMyTablesData("1", "a", client),
        isA<List<TableModel>>(),
      );
    });
  });
}
