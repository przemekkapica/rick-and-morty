import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_favorites.dart';

part 'favorites_store.g.dart';

@injectable
class FavoritesStore extends _FavoritesStore with _$FavoritesStore {
  FavoritesStore(super.getFavorites);
}

abstract class _FavoritesStore with Store {
  _FavoritesStore(this._getFavorites);

  final GetFavorites _getFavorites;

  @observable
  List<Character> favorites = [];

  @action
  Future<void> fetchFavorites() async {
    favorites = await _getFavorites();
  }
}
