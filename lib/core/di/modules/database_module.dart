import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/database/initialize_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  Future<Isar> get database async => initializeDatabase();
}
