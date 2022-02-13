class AppUrl {
  static const String baseUrl = 'http://10.0.2.2:80';

  static const String login = baseUrl + '/user/login';
  static const String register = baseUrl + '/user/register';
  static const String tableAdd = baseUrl + '/table/add';
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
}
