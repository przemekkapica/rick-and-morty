import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/characters/model/base_character.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';
import 'package:rick_and_morty/domain/characters/model/pagination_info.f.dart';
import 'package:rick_and_morty/domain/networking/model/connection_state.dart';
import 'package:rick_and_morty/domain/use_cases/add_to_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters.dart';
import 'package:rick_and_morty/domain/use_cases/get_connection_status.dart';
import 'package:rick_and_morty/domain/use_cases/get_connection_status_stream.dart';
import 'package:rick_and_morty/domain/use_cases/get_local_characters.dart';
import 'package:rick_and_morty/domain/use_cases/is_favorite_character.dart';
import 'package:rick_and_morty/domain/use_cases/remove_from_favorites.dart';
import 'package:rick_and_morty/domain/use_cases/save_characters_to_database.dart';
import 'package:rick_and_morty/domain/use_cases/update_local_character.dart';

part 'characters_list_store.g.dart';

enum CharactersListState { empty, loading, idle, error }

final _initialPagination = PaginationInfo(
  currentPage: 1,
  totalPages: 1,
  hasPrevious: false,
  hasNext: false,
);

final _offlinePagination = _initialPagination;

@injectable
class CharactersListStore extends _CharactersListStore
    with _$CharactersListStore {
  CharactersListStore(
    super.getCharacters,
    super._addToFavorites,
    super._getLocalCharacters,
    super._removeFromFavorites,
    super._saveCharactersToDatabase,
    super._isFavoriteCharacter,
    super._updateLocalCharacter,
    super._getConnectionStatus,
    super._getConnectionStatusStream,
  );
}

abstract class _CharactersListStore with Store {
  _CharactersListStore(
    this._getCharacters,
    this._addToFavorites,
    this._removeFromFavorites,
    this._getLocalCharacters,
    this._saveCharactersToDatabase,
    this._isFavoriteCharacter,
    this._updateLocalCharacter,
    this._getConnectionStatus,
    this._getConnectionStatusStream,
  ) {
    _connectionStatusSubscription =
        _getConnectionStatusStream().listen(_onConnectionStatusChanged);
  }

  final GetCharacters _getCharacters;
  final GetLocalCharacters _getLocalCharacters;
  final AddToFavorites _addToFavorites;
  final RemoveFromFavorites _removeFromFavorites;
  final SaveCharactersToDatabase _saveCharactersToDatabase;
  final IsFavoriteCharacter _isFavoriteCharacter;
  final UpdateLocalCharacter _updateLocalCharacter;

  final GetConnectionStatus _getConnectionStatus;
  final GetConnectionStatusStream _getConnectionStatusStream;

  late final StreamSubscription _connectionStatusSubscription;

  @observable
  List<Character> characters = [];

  @observable
  PaginationInfo paginationInfo = _initialPagination;

  @observable
  ObservableFuture<CharactersPage> _charactersPageFuture =
      ObservableFuture.value(
    CharactersPage(
      characters: [],
      paginationInfo: _initialPagination,
    ),
  );

  @readonly
  CharactersListState _state = CharactersListState.loading;

  CharactersFilter? _lastFilter;

  @action
  Future<void> fetchCharacters(
    int? pageNumber,
    int? pageModifier,
    CharactersFilter? filter,
  ) async {
    _lastFilter = filter;
    _state = CharactersListState.loading;
    final connectionStatus = await _getConnectionStatus();

    if (connectionStatus.isConnected) {
      await _fetchRemoteCharacters(pageNumber, filter, pageModifier);
    } else {
      await _fetchLocalCharacters();
    }
  }

  Future<void> _fetchLocalCharacters() async {
    try {
      characters = await _getLocalCharacters();
      paginationInfo = _offlinePagination;

      _emitLoaded();
    } catch (e) {
      _state = CharactersListState.error;
    }
  }

  Future<void> _fetchRemoteCharacters(
    int? pageNumber,
    CharactersFilter? filter,
    int? pageModifier,
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

      paginationInfo = response.paginationInfo;
      characters = response.characters;

      _emitLoaded();

      await _saveCharactersToDatabase(characters);
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

  void _onConnectionStatusChanged(ConnectionStatus status) {
    fetchCharacters(paginationInfo.currentPage, null, _lastFilter);
  }

  @action
  Future<void> onFavoritesTap(BaseCharacter character) async {
    final isFavorite = await _isFavoriteCharacter(character.id);
    if (isFavorite) {
      await _removeFromFavorites(character.id);
    } else {
      await _addToFavorites(character);
    }
    await _updateLocalCharacter(
      Character.fromBaseCharacter(character, !isFavorite),
    );
    fetchCharacters(paginationInfo.currentPage, null, _lastFilter);
  }

  void dispose() {
    _connectionStatusSubscription.cancel();
  }
}
