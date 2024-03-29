import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

class LocalDatabase {
  static late final Isar database;

  static Future<void> initializeDatabase() async {
    final dir = await getApplicationDocumentsDirectory();

    database = await Isar.open(
      [
        CharacterSchema,
        FavoriteCharacterSchema,
      ],
      directory: dir.path,
    );
  }
}
