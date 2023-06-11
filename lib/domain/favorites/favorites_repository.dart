import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

abstract class FavoritesRepository {
  Future<List<FavoriteCharacter>> getFavorites();

  Future<void> addToFavorites(FavoriteCharacter character);

  Future<void> removeFromFavorites(int id);
}
