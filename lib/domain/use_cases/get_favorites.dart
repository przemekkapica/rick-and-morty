import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';

@injectable
class GetFavorites {
  GetFavorites(this._repository);

  final FavoritesRepository _repository;

  Future<List<Character>> call() async {
    return await _repository.getFavorites();
  }
}
