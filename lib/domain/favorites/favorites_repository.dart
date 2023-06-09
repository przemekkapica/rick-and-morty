import 'package:rick_and_morty/domain/characters/model/character.f.dart';

abstract class FavoritesRepository {
  Future<List<Character>> getFavorites();

  Future<void> addToFavorites(Character character);

  Future<void> removeFromFavorites(int id);
}
