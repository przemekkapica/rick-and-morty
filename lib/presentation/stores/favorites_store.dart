import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';

part 'favorites_store.g.dart';

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

  @observable
  List<Character> favorites = [];

  @action
  Future<void> fetchFavorites() async {
    favorites = await _getFavorites();
  }

  @action
  Future<void> removeFromFavorites(Character character) async {
    await _removeFromFavorites(character.id);
    favorites = await _getFavorites();
  }
}
