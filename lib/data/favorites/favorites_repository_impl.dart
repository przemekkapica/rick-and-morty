import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/favorites/data_sources/favorites_data_source.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._favoritesDataSource);

  final FavoritesDataSource _favoritesDataSource;

  @override
  Future<List<FavoriteCharacter>> getFavorites() async {
    return await _favoritesDataSource.getFavorites();
  }

  @override
  Future<void> addToFavorites(FavoriteCharacter character) async {
    return await _favoritesDataSource.addToFavorites(character);
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    return await _favoritesDataSource.removeFromFavorites(id);
  }
}
