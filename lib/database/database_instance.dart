import 'package:restro_booking/database/mydatabase.dart';

class DatabaseInstance {
  static DatabaseInstance? _instance;

  DatabaseInstance._();
  static DatabaseInstance get instance => _instance ??= DatabaseInstance._();

  Future<AppDatabase> getDatabaseInstance() {
    return $FloorAppDatabase.databaseBuilder('my_database.db').build();
  }
}
