import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/favorites/favorites_repository.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';

@injectable
class AddToFavorites {
  AddToFavorites(this._repository);

  final FavoritesRepository _repository;

  Future<void> call(BaseCharacter character) async {
    final favorite = FavoriteCharacter.fromBaseCharacter(character);

    return await _repository.addToFavorites(favorite);
  }
}
