import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart';
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/characters/model/characters_filter.f.dart';

@LazySingleton(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(
    this._dataSource,
    this._characterMapper,
    this._statusMapper,
    this._genderMapper,
  );

  final CharactersDataSource _dataSource;
  final CharacterMapper _characterMapper;
  final StatusMapper _statusMapper;
  final GenderMapper _genderMapper;

  @override
  Future<List<Character>> getCharacters(
    int? page,
    CharactersFilter filter,
  ) async {
    final response = await _dataSource.getCharacters(
      page,
      filter.name,
      filter.status != null ? _statusMapper.toDTO(filter.status!) : null,
      filter.species,
      filter.gender != null ? _genderMapper.toDTO(filter.gender!) : null,
    );

    return response.results
        .map((characterDto) => _characterMapper(characterDto))
        .toList();
  }
}
