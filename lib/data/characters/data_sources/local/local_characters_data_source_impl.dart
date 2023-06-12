import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/characters/data_sources/local/local_characters_data_source.dart';
import 'package:rick_and_morty/data/database/local_database.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

@LazySingleton(as: LocalCharactersDataSource)
class LocalCharactersDataSourceImpl implements LocalCharactersDataSource {
  @override
  Future<void> addCharacter(Character character) async {
    return await LocalDatabase.database.writeTxn(() async {
      LocalDatabase.database.characters.put(character);
    });
  }

  @override
  Future<bool> checkIfCharacterExists(int id) async {
    return await LocalDatabase.database.characters
            .where()
            .idEqualTo(id)
            .findFirst() !=
        null;
  }

  @override
  Future<List<Character>> getCharacters() async {
    return await LocalDatabase.database.characters.where().findAll();
  }

  @override
  Future<void> removeCharacter(int id) async {
    return await LocalDatabase.database.writeTxn(() async {
      LocalDatabase.database.characters.delete(id);
    });
  }

  @override
  Future<bool> isFavorite(int id) async {
    return await LocalDatabase.database.favoriteCharacters
            .where()
            .idEqualTo(id)
            .findFirst() !=
        null;
  }

  @override
  Future<void> updateCharacter(Character character) async {
    return await LocalDatabase.database.writeTxn(() async {
      LocalDatabase.database.characters.put(character);
    });
  }
}
