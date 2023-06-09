import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';

part 'characters_list_store.g.dart';

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
  CharactersListStore(
    super.getCharacters,
    super._addToFavorites,
  );
}

abstract class _CharactersListStore with Store {
  _CharactersListStore(
    this._getCharacters,
    this._addToFavorites,
  );

  final GetCharacters _getCharacters;
  final AddToFavorites _addToFavorites;

  @observable
  List<Character> characters = [];

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

  @readonly
  CharactersListState _state = CharactersListState.loading;

  @action
  Future<void> fetchCharacters(
    int? pageNumber,
    int? pageModifier,
    CharactersFilter? filter,
  ) async {
    _state = CharactersListState.loading;
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

      paginationInfo = response.paginationInfo;
      characters = response.characters;

      _emitLoaded();
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      _state = CharactersListState.error;
    }
  }

  void _emitLoaded() {
    if (characters.isEmpty) {
      _state = CharactersListState.empty;
    } else {
      _state = CharactersListState.idle;
    }
  }

  void _handleDioException(DioException e) {
    if (e.response != null) {
      if (e.response!.statusCode != null && e.response!.statusCode! == 404) {
        _state = CharactersListState.empty;
      } else {
        _state = CharactersListState.error;
      }
    } else {
      _state = CharactersListState.error;
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

  @action
  Future<void> addToFavorites(Character character) async {
    return await _addToFavorites(character);
  }
}
