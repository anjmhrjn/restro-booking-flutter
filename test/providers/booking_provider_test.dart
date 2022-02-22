import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/utility/app_url.dart';
import 'package:restro_booking/providers/booking_provider.dart';

import 'booking_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('booking', () {
    test(
        'returns bool value if the http call completes successfully for making reservation',
        () async {
      BookingModel bookingData = BookingModel(
        created_date: '2022-02-22',
        requested_for: '2022-02-22',
        start_time: '11:10',
        end_time: '11:30',
        total_seats: '2',
        table: '1',
        user: '1',
      );
      final bookingMap = bookingData.toJson();
      bookingMap.removeWhere((key, value) => key == "_id");
      bookingMap.removeWhere((key, value) => key == "booking_status");
      bookingMap.removeWhere((key, value) => key == "table_detail");
      bookingMap.removeWhere((key, value) => key == "user_detail");
      final client = MockClient();
      when(client.post(
        Uri.parse(AppUrl.bookTable),
        body: bookingMap,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('{"success": true}', 200));
      expect(
        await BookingProvider().makeReservation(bookingData, "a", client),
        isA<bool>(),
      );
    });
  });
}
