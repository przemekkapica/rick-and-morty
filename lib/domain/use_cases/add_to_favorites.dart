import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';

@injectable
class AddToFavorites {
  AddToFavorites(this._repository);

  final FavoritesRepository _repository;

  Future<void> call(Character character) async {
    return await _repository.addToFavorites(character);
  }
}
