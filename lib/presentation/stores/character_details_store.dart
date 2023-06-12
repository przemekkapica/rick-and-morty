import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/domain/use_cases/get_connection_status.dart';
import 'package:rick_and_morty/domain/use_cases/get_local_characters.dart';
import 'package:rick_and_morty/domain/use_cases/is_favorite_character.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/update_local_character.dart';

part 'character_details_store.g.dart';

enum CharacterDetailsState { idle, error }

@injectable
class CharacterDetailsStore extends _CharacterDetailsStore
    with _$CharacterDetailsStore {
  CharacterDetailsStore(
    super._addToFavorites,
    super._removeFromFavorites,
    super._updateLocalCharacter,
    super._isFavoriteCharacter,
    super._getConnectionStatus,
    super._getCharacters,
    super._getLocalCharacters,
  );
}

abstract class _CharacterDetailsStore with Store {
  _CharacterDetailsStore(
    this._addToFavorites,
    this._removeFromFavorites,
    this._updateLocalCharacter,
    this._isFavoriteCharacter,
    this._getConnectionStatus,
    this._getCharacters,
    this._getLocalCharacters,
  );

  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
  final UpdateLocalCharacter _updateLocalCharacter;
  final IsFavoriteCharacter _isFavoriteCharacter;
  final GetConnectionStatus _getConnectionStatus;
  final GetCharacters _getCharacters;
  final GetLocalCharacters _getLocalCharacters;

  @action
  void init(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  @readonly
  CharacterDetailsState _state = CharacterDetailsState.idle;

  @readonly
  bool _isFavorite = false;

  @action
  Future<void> onFavoritesTap(BaseCharacter character) async {
    try {
      final isFavorite = await _isFavoriteCharacter(character.id);
      if (isFavorite) {
        await _removeFromFavorites(character.id);
        _isFavorite = false;
      } else {
        await _addToFavorites(character);
        _isFavorite = true;
      }
      _state = CharacterDetailsState.idle;
      await _updateLocalCharacter(
        Character.fromBaseCharacter(character, !isFavorite),
      );
    } catch (e) {
      _state = CharacterDetailsState.error;
    }
  }

  @action
  Future<List<Character>> getCharactersOnPop() async {
    // TODO: feed with latest pagination and filters
    try {
      final status = await _getConnectionStatus();
      if (status.isConnected) {
        final result = await _getCharacters(null, null);
        return result.characters;
      } else {
        return await _getLocalCharacters(null);
      }
    } catch (e) {
      _state = CharacterDetailsState.error;
      return [];
    }
  }
}
