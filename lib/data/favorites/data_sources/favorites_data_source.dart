import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

abstract class FavoritesDataSource {
  Future<List<FavoriteCharacter>> getFavorites();

  Future<void> addToFavorites(FavoriteCharacter character);

  Future<void> removeFromFavorites(int id);
}
