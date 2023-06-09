import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';

part 'characters_list_store.g.dart';

typedef Characters = List<Character>;

enum CharactersListState { empty, loading, idle, error }

final initialPagination = PaginationInfo(
  currentPage: 1,
  totalPages: 1,
  hasPrevious: false,
  hasNext: true,
);

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
  PaginationInfo paginationInfo = initialPagination;

  @observable
  ObservableFuture<CharactersPage> _charactersPageFuture =
      ObservableFuture.value(
    CharactersPage(
      characters: [],
      paginationInfo: initialPagination,
    ),
  );

  @action
  Future<void> fetchCharacters(
    int? pageNumber,
    int? pageModifier,
    CharactersFilter? filter,
  ) async {
    try {
      if (pageNumber != null) {
        _asignCharactersPageFuture(pageNumber, filter);
      } else {
        _asignCharactersPageFuture(
          paginationInfo.currentPage + (pageModifier ?? 0),
          filter,
        );
      }

      final response = await _charactersPageFuture;

      characters = response.characters;
      paginationInfo = response.paginationInfo;
    } catch (e) {
      print(e);
    }
  }

  void _asignCharactersPageFuture(int pageNumber, CharactersFilter? filter) {
    _charactersPageFuture = ObservableFuture(
      _getCharacters(
        pageNumber,
        filter ?? const CharactersFilter(),
      ),
    );
  }

  @computed
  CharactersListState get state {
    switch (_charactersPageFuture.status) {
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
