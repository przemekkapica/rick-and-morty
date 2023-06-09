import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';

part 'favorites_store.g.dart';

enum FavoritesState { loading, empty, idle, error }

@injectable
class FavoritesStore extends _FavoritesStore with _$FavoritesStore {
  FavoritesStore(
    super.getFavorites,
    super._removeFromFavorites,
  );
}

abstract class _FavoritesStore with Store {
  _FavoritesStore(
    this._getFavorites,
    this._removeFromFavorites,
  );

  final GetFavorites _getFavorites;
  final RemoveFromFavorites _removeFromFavorites;

  @readonly
  FavoritesState _state = FavoritesState.loading;

  @observable
  List<Character> favorites = [];

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
  Future<void> removeFromFavorites(Character character) async {
    try {
      await _removeFromFavorites(character.id);
      favorites = await _getFavorites();
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
}
