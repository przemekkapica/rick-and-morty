import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/characters/dtos/character_dto.dart';
import 'package:rick_and_morty/data/characters/mappers/gender_mapper.dart';
import 'package:rick_and_morty/data/characters/mappers/status_mapper.dart';
import 'package:rick_and_morty/domain/characters/model/character.f.dart';
import 'package:rick_and_morty/domain/mappers/data_mapper.dart';

@injectable
class CharacterMapper extends DataMapper<CharacterDTO, Character> {
  CharacterMapper(
    this._statusMapper,
    this._genderMapper,
  );

  final StatusMapper _statusMapper;
  final GenderMapper _genderMapper;

  @override
  Character call(CharacterDTO dto) {
    return Character(
      id: dto.id,
      name: dto.name,
      status: _statusMapper.fromDTO(dto.status),
      image: dto.image,
      species: dto.species,
      created: dto.created,
      gender: _genderMapper.fromDTO(dto.gender),
      location: dto.location.name,
      origin: dto.origin.name,
      type: dto.type,
      isFavorite: false,
    );
  }
}
