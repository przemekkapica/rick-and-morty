import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';

part 'character_details_store.g.dart';

enum CharacterDetailsState { idle, error }

@injectable
class CharacterDetailsStore extends _CharacterDetailsStore
    with _$CharacterDetailsStore {
  CharacterDetailsStore(
    super._addToFavorites,
    super._removeFromFavorites,
  );
}

abstract class _CharacterDetailsStore with Store {
  _CharacterDetailsStore(
    this._addToFavorites,
    this._removeFromFavorites,
  );

  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;

  @readonly
  CharacterDetailsState _state = CharacterDetailsState.idle;

  @action
  Future<void> removeFromFavorites(Character character) async {
    try {
      await _removeFromFavorites(character.id);
      _state = CharacterDetailsState.idle;
    } catch (e) {
      _state = CharacterDetailsState.error;
    }
  }

  @action
  Future<void> addToFavorites(Character character) async {
    try {
      await _addToFavorites(character);
      _state = CharacterDetailsState.idle;
    } catch (e) {
      _state = CharacterDetailsState.error;
    }
  }
}
