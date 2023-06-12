import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/favorites/model/favorite_character.f.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/domain/use_cases/get_connection_status.dart';
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/get_latest_characters_filter.dart';
import 'package:rick_and_morty/domain/use_cases/get_latest_pagination_info.dart';
import 'package:rick_and_morty/domain/use_cases/get_local_characters.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';

part 'favorites_store.g.dart';

enum FavoritesState { loading, empty, idle, error }

@injectable
class FavoritesStore extends _FavoritesStore with _$FavoritesStore {
  FavoritesStore(
    super._getFavorites,
    super._removeFromFavorites,
    super._getLocalCharacters,
    super._getCharacters,
    super._getConnectionStatus,
    super._getLatestCharactersFilter,
    super._getLatestPaginationInfo,
  );
}

abstract class _FavoritesStore with Store {
  _FavoritesStore(
    this._getFavorites,
    this._removeFromFavorites,
    this._getLocalCharacters,
    this._getCharacters,
    this._getConnectionStatus,
    this._getLatestCharactersFilter,
    this._getLatestPaginationInfo,
  );

  final GetFavorites _getFavorites;
  final GetCharacters _getCharacters;
  final GetLocalCharacters _getLocalCharacters;
  final RemoveFromFavorites _removeFromFavorites;
  final GetConnectionStatus _getConnectionStatus;
  final GetLatestCharactersFilter _getLatestCharactersFilter;
  final GetLatestPaginationInfo _getLatestPaginationInfo;

  @readonly
  FavoritesState _state = FavoritesState.loading;

  @observable
  List<FavoriteCharacter> favorites = [];

  @action
  Future<void> fetchFavorites() async {
    _state = FavoritesState.loading;
    try {
      favorites = await _getFavorites();
      _emitLoaded();
    } catch (e) {
      _state = FavoritesState.error;
    }
  }

  @action
  Future<void> removeFromFavorites(BaseCharacter character) async {
    try {
      await _removeFromFavorites(character.id);

      final favoritesCopy = List<FavoriteCharacter>.from(favorites);
      favoritesCopy.remove(character);

      favorites = List.of(favoritesCopy);
      _emitLoaded();
    } catch (e) {
      _state = FavoritesState.error;
    }
  }

  void _emitLoaded() {
    if (favorites.isEmpty) {
      _state = FavoritesState.empty;
    } else {
      _state = FavoritesState.idle;
    }
  }

  @action
  Future<List<Character>> getCharactersOnPop() async {
    try {
      final status = await _getConnectionStatus();
      if (status.isConnected) {
        final result = await _getCharacters(
          _getLatestPaginationInfo().currentPage,
          _getLatestCharactersFilter(),
        );
        return result.characters;
      } else {
        return await _getLocalCharacters(_getLatestCharactersFilter());
      }
    } catch (e) {
      _state = FavoritesState.error;
      return [];
    }
  }
}
