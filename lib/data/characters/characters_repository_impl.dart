import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/data_sources/local/local_characters_data_source.dart';
import 'package:rick_and_morty/data/characters/data_sources/remote/remote_characters_data_source.dart';
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/pagination_info_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_page.f.dart';

@LazySingleton(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._characterMapper,
    this._statusMapper,
    this._genderMapper,
    this._paginationInfoMapper,
  );

  final RemoteCharactersDataSource _remoteDataSource;
  final LocalCharactersDataSource _localDataSource;
  final CharacterMapper _characterMapper;
  final StatusMapper _statusMapper;
  final GenderMapper _genderMapper;
  final PaginationInfoMapper _paginationInfoMapper;

  @override
  Future<CharactersPage> getCharacters(
    int? page,
    CharactersFilter filter,
  ) async {
    final response = await _remoteDataSource.getCharacters(
      page,
      filter.name,
      filter.status != null ? _statusMapper.toDTO(filter.status!) : null,
      filter.species,
      filter.gender != null ? _genderMapper.toDTO(filter.gender!) : null,
    );

    final paginationInfo = _paginationInfoMapper(response.info);

    final characters = response.results.map((characterDto) async {
      final domainCharacter = _characterMapper(characterDto);

      final isFavorite = await isFavoriteCharacter(domainCharacter.id);
      return domainCharacter.copyWith(isFavorite: isFavorite);
    }).toList();

    final mappedCharacters = await Future.wait(characters);

    return CharactersPage(
      characters: mappedCharacters,
      paginationInfo: paginationInfo,
    );
  }

  @override
  Future<void> saveToDatabase(Character character) async {
    final alreadyExists = await checkIfLocalCharacterExists(character.id);

    if (!alreadyExists) {
      return await _localDataSource.addCharacter(character);
    }
  }

  @override
  Future<List<Character>> getLocalCharacters() async {
    final result = await _localDataSource.getCharacters();

    final characters = result.map((character) async {
      final isFavorite = await isFavoriteCharacter(character.id);

      return character.copyWith(isFavorite: isFavorite);
    });

    final mappedCharacters = await Future.wait(characters);

    return mappedCharacters;
  }

  @override
  Future<bool> checkIfLocalCharacterExists(int id) async {
    return await _localDataSource.checkIfCharacterExists(id);
  }

  @override
  Future<bool> isFavoriteCharacter(int id) async {
    return await _localDataSource.isFavorite(id);
  }

  @override
  Future<void> updateLocalCharacter(Character character) async {
    return await _localDataSource.updateCharacter(character);
  }
}
