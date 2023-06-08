import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/data_sources/characters_data_source.dart';
import 'package:rick_and_morty/data/characters/mappers/character_mapper.dart';
import 'package:rick_and_morty/domain/characters/characters_repository.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';

@LazySingleton(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(
    this._dataSource,
    this._characterMapper,
  );

  final CharactersDataSource _dataSource;
  final CharacterMapper _characterMapper;

  @override
  Future<List<Character>> getCharacters() async {
    final response = await _dataSource.getCharacters();

    return response.results
        .map((characterDto) => _characterMapper(characterDto))
        .toList();
  }
}
