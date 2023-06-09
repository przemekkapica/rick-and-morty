import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';

part 'characters_list_store.g.dart';

typedef Characters = List<Character>;

enum CharactersListState { empty, loading, idle, error }

@injectable
class CharactersListStore extends _CharactersListStore
    with _$CharactersListStore {
  CharactersListStore(super.getCharacters);
}

abstract class _CharactersListStore with Store {
  _CharactersListStore(this._getCharacters);

  final GetCharacters _getCharacters;

  @observable
  Characters characters = [];

  @observable
  ObservableFuture<Characters> _charactersFuture = ObservableFuture.value([]);

  @action
  Future<void> fetchCharacters(
    CharactersFilter? filter,
  ) async {
    try {
      _charactersFuture = ObservableFuture(
        _getCharacters(null, filter ?? const CharactersFilter()),
      );

      characters = await _charactersFuture;
    } catch (e) {
      print(e);
    }
  }

  @computed
  CharactersListState get state {
    if (_charactersFuture.value == []) {
      return CharactersListState.empty;
    }
    switch (_charactersFuture.status) {
      case FutureStatus.pending:
        return CharactersListState.loading;
      case FutureStatus.fulfilled:
        return CharactersListState.idle;
      case FutureStatus.rejected:
        return CharactersListState.error;
      default:
        return CharactersListState.empty;
    }
  }
}
