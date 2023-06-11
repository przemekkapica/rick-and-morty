import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/database/local_database.dart';
import 'package:rick_and_morty/data/favorites/data_sources/favorites_data_source.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

@LazySingleton(as: FavoritesDataSource)
class LocalFavoritesDataSource implements FavoritesDataSource {
  LocalFavoritesDataSource();

  @override
  Future<List<FavoriteCharacter>> getFavorites() async {
    return await LocalDatabase.database.favoriteCharacters.where().findAll();
  }

  @override
  Future<void> addToFavorites(FavoriteCharacter character) async {
    return await LocalDatabase.database.writeTxn(() async {
      LocalDatabase.database.favoriteCharacters.put(character);
    });
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    return await LocalDatabase.database.writeTxn(() async {
      LocalDatabase.database.favoriteCharacters.delete(id);
    });
  }
}
