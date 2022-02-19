class AppUrl {
  static const String baseUrl = 'http://10.0.2.2:80';

  static const String login = baseUrl + '/user/login';
  static const String register = baseUrl + '/user/register';
  static const String tableAdd = baseUrl + '/table/add';
  static const String tableBulkAdd = baseUrl + '/table/bulk/add';
  static const String myTables = baseUrl + '/table/user/';
  static const String deleteTable = baseUrl + '/table/delete/';
  static const String updateTable = baseUrl + '/table/update/';
  static const String addCategory = baseUrl + '/category/add';
  static const String getCategory = baseUrl + '/all-categories/';
  static const String deleteCategory = baseUrl + '/category/delete/';
  static const String addItem = baseUrl + '/mobile/item/add';
  static const String updateItem = baseUrl + '/item/update/';
  static const String myItems = baseUrl + '/my-items/';
  static const String deleteItem = baseUrl + '/item/delete/';
  static const String bookTable = baseUrl + '/book/table';
  static const String businessBooking = baseUrl + '/business/my-booking';
  static const String updateBooking = baseUrl + '/update/booking/';
  static const String updateBookingStatus = baseUrl + '/booking/update-status/';
  static const String filterBooking = baseUrl + '/booking/filter';

  // customer api routes
  static const String getAllBusiness = baseUrl + '/all-business';
  static const String searchRestro = baseUrl + '/search-restaurant/';
  static const String getRestroItems = baseUrl + '/users-items/';
  static const String getMyBooking = baseUrl + '/my-bookings';

  ///booking/update-status/
}
